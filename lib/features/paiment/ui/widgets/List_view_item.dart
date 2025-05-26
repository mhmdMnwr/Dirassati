import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/font_weight.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/paiment/data/model/paiment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirasati/core/theming/colors.dart'; // Assuming you might need custom colors

class PayStudentCard extends StatelessWidget {
  final PaimentModel paiment;
  const PayStudentCard({super.key, required this.paiment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: 16.w), // Increased vertical padding
      child: Container(
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
      height: 110.h, // Adjusted height to match more content
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue, // Using a color from your ColorsManager
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // Assuming PaimentModel has these fields, adjust if necessary
    String nextAmount = paiment.nextPaymentAmount?.toStringAsFixed(2) ?? 'N/A';
    String nextDate =
        paiment.nextPaymentDate?.toIso8601String().substring(0, 10) ??
            'N/A'; // Example formatting

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStudentName(),
        verticalSpace(5.h),
        _buildStudentLevel(),
        verticalSpace(8.h),
        _buildDetailRow('Next Amount to Pay:', '$nextAmount DZD'),
        verticalSpace(5.h),
        _buildDetailRow('Next Date to Pay:', nextDate),
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
    return Text(
      '${paiment.student?.firstName ?? ''} ${paiment.student?.lastName ?? 'Unknown Student'}'
          .trim(),
      style: TextStyles.font16BlackBold.copyWith(
        fontSize: 17.sp, // Slightly larger
        color: ColorsManager.darkBlue, // Using a color from your ColorsManager
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStudentLevel() {
    return Text(
      paiment.student?.level ?? 'N/A',
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
    String totalAmount = paiment.amount?.toStringAsFixed(2) ?? 'N/A';

    return Padding(
      padding:
          EdgeInsets.only(right: 16.w, left: 8.w), // Add some left padding too
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            'Total Due',
            style: TextStyles.font12GrayRegular.copyWith(fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
