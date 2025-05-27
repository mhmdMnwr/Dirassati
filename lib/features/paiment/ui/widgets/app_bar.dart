import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Constants for dimensions and styling
const double _kAppBarHeight = 255.0;
const double _kBottomBorderRadius = 30.0;
const double _kCardBorderRadius = 15.0;
const double _kCardElevationBlurRadius = 10.0;
const double _kCardElevationOffsetY = 5.0;
const double _kHorizontalPadding = 20.0;
const double _kTitleTopPadding = 10.0;
const double _kBackButtonSize = 35.0;
const double _kSizedBoxWidth = 10.0;
const double _kCardContentVerticalPadding = 20.0;
const double _kCardContentHorizontalPadding = 15.0;
const double _kInterElementSpacingSmall = 4.0;
const double _kInterElementSpacingMedium = 8.0;
const double _kInterElementSpacingLarge = 15.0;

class PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String nextPaiment;
  final String nextPaymentDate;
  final String totalToPay;
  final int daysLeft; // Example value, replace with actual logic

  const PaymentAppBar({
    super.key,
    required this.title,
    required this.daysLeft,
    required this.nextPaiment,
    required this.nextPaymentDate,
    required this.totalToPay,
  });

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = ScreenUtil().statusBarHeight;
    return Stack(
      clipBehavior: Clip.none, // Allow card to overflow
      children: [
        const _BlueBackgroundContainer(),
        _AppBarTitleWithBackButton(
            title: title, statusBarHeight: statusBarHeight),
        _PaymentDetailsCard(
          daysLeft: daysLeft,
          totalToPay: totalToPay,
          nextPaymentDate: nextPaymentDate,
          nextPaiment: nextPaiment, // Fixed typo here
          statusBarHeight: statusBarHeight,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_kAppBarHeight.h);
}

class _BlueBackgroundContainer extends StatelessWidget {
  const _BlueBackgroundContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 18.h, // Adjust for the bottom border radius
      ),
      height: _kAppBarHeight.h,
      decoration: BoxDecoration(
        color: ColorsManager.skyBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_kBottomBorderRadius.r),
          bottomRight: Radius.circular(_kBottomBorderRadius.r),
        ),
      ),
    );
  }
}

class _AppBarTitleWithBackButton extends StatelessWidget {
  final String title;
  final double statusBarHeight;

  const _AppBarTitleWithBackButton({
    required this.title,
    required this.statusBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: statusBarHeight + _kTitleTopPadding.h,
      left: _kSizedBoxWidth.w,
      right: _kSizedBoxWidth.w,
      child: Row(
        children: [
          IconButton(
            icon: Image.asset(
              IconsManager.backButton,
              width: _kBackButtonSize.w,
              height: _kBackButtonSize.h,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: _kSizedBoxWidth.w),
          Text(
            title,
            style: TextStyles.font20Whitebold,
          ),
        ],
      ),
    );
  }
}

class _PaymentDetailsCard extends StatelessWidget {
  final String totalToPay;
  final String nextPaymentDate;
  final String nextPaiment; // Fixed typo here
  final double statusBarHeight;
  final int daysLeft; // Example value, replace with actual logic

  const _PaymentDetailsCard({
    required this.daysLeft,
    required this.totalToPay,
    required this.nextPaymentDate,
    required this.nextPaiment, // Fixed typo here
    required this.statusBarHeight,
  });

  // Determine singular/plural

  @override
  Widget build(BuildContext context) {
    final String day = (daysLeft == 1) ? 'day' : 'days';
    return Positioned(
      top: statusBarHeight + 70.h, // Position below title
      left: _kHorizontalPadding.w,
      right: _kHorizontalPadding.w,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: _kCardContentVerticalPadding.h,
          horizontal: _kCardContentHorizontalPadding.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_kCardBorderRadius.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1.0.r,
              blurRadius: _kCardElevationBlurRadius.r,
              offset: Offset(0, _kCardElevationOffsetY.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total to pay',
              style: TextStyles.font14GrayRegular,
            ),
            SizedBox(height: _kInterElementSpacingMedium.h),
            Text(
              totalToPay,
              style: TextStyles.font32BlueBold
                  .copyWith(color: ColorsManager.mainBlue),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: _kInterElementSpacingLarge.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PaymentDetailItem(
                  label: 'Next Date to Pay',
                  value: '$nextPaymentDate ( $daysLeft $day left)',
                ),
                _PaymentDetailItem(
                  label: 'Next amount to pay',
                  value: nextPaiment, // Fixed typo here
                  isAlignedEnd: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isAlignedEnd;

  const _PaymentDetailItem({
    required this.label,
    required this.value,
    this.isAlignedEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isAlignedEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.font12GrayRegular,
        ),
        SizedBox(height: _kInterElementSpacingSmall.h),
        Text(
          value,
          style: TextStyles.font14DarkBlueMedium,
        ),
      ],
    );
  }
}

// Example Usage (can be in another file):
// Scaffold(
//   appBar: PaymentAppBar(
//     title: 'Payment Details',
//     totalToPay: 'DZD 5,000.00',
//     nextPaymentDate: '2025-06-15',
//     totalPayed: 'DZD 10,000.00',
//   ),
//   body: Container(),
// )
