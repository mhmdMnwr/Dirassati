import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/font_weight.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/paiment/data/model/paiment_model.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirasati/core/theming/colors.dart'; // Assuming you might need custom colors

class PayStudentCard extends StatefulWidget {
  final PaimentModel paiment;
  const PayStudentCard({super.key, required this.paiment});

  @override
  State<PayStudentCard> createState() => _PayStudentCardState();
}

class _PayStudentCardState extends State<PayStudentCard> {
  bool _isNameExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double containerHeight = _isNameExpanded ? 187.h : 167.h;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: 16.w), // Increased vertical padding
      child: Container(
        height: containerHeight, // Dynamic height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08), // Softer shadow
              blurRadius: 10.r, // Increased blur
              offset: const Offset(0, 4), // Adjusted offset
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Add this line
          children: [
            _buildAccentStripe(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h), // Increased vertical padding
                child: _buildContent(context),
              ),
            ),
            _buildTotalAmountWithIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAccentStripe(BuildContext context) {
    return Container(
      width: 5.w, // Slightly thicker
      // Consider making height dynamic or ensuring it fits both 160.h and 180.h card heights
      // For now, let's keep it as is, or adjust based on visual needs.
      // height: _isNameExpanded ? 170.h : 150.h, // Example of dynamic accent stripe
      decoration: BoxDecoration(
        color: ColorsManager.skyBlue, // Using a color from your ColorsManager
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // Assuming PaimentModel has these fields, adjust if necessary
    String nextAmount =
        widget.paiment.nextPaymentAmount?.toStringAsFixed(2) ?? 'N/A';
    String nextDate = widget.paiment.formatedDate; // Example formatting

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Important for Column within Expanded
      children: [
        _buildStudentName(),
        verticalSpace(5.h),
        _buildStudentLevel(),
        verticalSpace(8.h),
        _buildDetailRow(
            AppLocalizations.of(context)!.nextAmountToPay, '$nextAmount DZD'),
        verticalSpace(5.h),
        _buildDetailRow(AppLocalizations.of(context)!.nextDateToPay, nextDate),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.font12GrayMedium),
        Text(value,
            style: TextStyles.font12SkyBlueRegular
                .copyWith(fontWeight: FontWeightHelper.medium)),
      ],
    );
  }

  Widget _buildStudentName() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isNameExpanded = !_isNameExpanded;
        });
      },
      child: Text(
        '${widget.paiment.student?.firstName ?? ''} ${widget.paiment.student?.lastName ?? 'Unknown Student'}'
            .trim(),
        style: TextStyles.font16BlackBold.copyWith(
          fontSize: 15.sp, // Slightly larger
          color:
              ColorsManager.darkBlue, // Using a color from your ColorsManager
        ),
        maxLines: _isNameExpanded ? 2 : 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStudentLevel() {
    return Text(
      widget.paiment.student?.level ??
          'N/A', // Corrected: Use paiment.student?.level directly
      style: TextStyles.font14DarkBlueMedium.copyWith(
        // Using a style from your TextStyles
        fontSize: 14.sp,
        color: ColorsManager
            .seconderyBlue, // Using a color from your ColorsManager
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTotalAmountWithIcon(BuildContext context) {
    // Assuming PaimentModel has this field, adjust if necessary
    String totalAmount = widget.paiment.amount?.toStringAsFixed(2) ?? 'N/A';

    return Padding(
      padding:
          EdgeInsets.only(right: 16.w, left: 8.w), // Add some left padding too
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment
            .center, // Keep this for vertical centering of this column's content
        children: [
          // verticalSpace(50), // This might need adjustment with dynamic card height
          const Spacer(flex: 2), // Pushes content down more
          Icon(
            Icons.attach_money,
            color:
                ColorsManager.mainBlue, // Using a color from your ColorsManager
            size: 28.sp,
          ),
          verticalSpace(4.h),
          Text(
            '$totalAmount DZD',
            style: TextStyles.font16BlackBold.copyWith(
                // Reusing a bold style
                color: ColorsManager
                    .mainBlue, // Using a color from your ColorsManager
                fontSize: 15.sp),
            textAlign: TextAlign.center,
          ),
          Text(
            AppLocalizations.of(context)!.totalDue,
            style: TextStyles.font12GrayRegular.copyWith(fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
          // verticalSpace(15), // Replaced by Spacer
          const Spacer(flex: 1),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              widget.paiment.paymentMode ?? 'N/A',
              style: TextStyles.font12GrayMedium.copyWith(
                color: ColorsManager.seconderyBlue,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
