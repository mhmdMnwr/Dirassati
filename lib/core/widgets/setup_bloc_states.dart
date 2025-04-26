import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/colors.dart'; // Assuming you have a colors file
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // If using screenutil

class SetupErrorState {
  static void show(BuildContext context, String error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: Colors.white,
        icon: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: ColorsManager.lighterGray.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 40.sp,
          ),
        ),
        title: Text(
          'Error',
          textAlign: TextAlign.center,
          style: TextStyles.font18DarkBlueBold,
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyles.font14DarkBlueMedium,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SetupLoadingState {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: ColorsManager.mainBlue, // Use your primary color
            ),
            SizedBox(height: 20.h),
            Text(
              'Loading...',
              textAlign: TextAlign.center,
              style: TextStyles.font14DarkBlueMedium,
            ),
          ],
        ),
      ),
    );
  }

  static Widget build() {
    return Center(
      child: CircularProgressIndicator(
        color: ColorsManager.mainBlue, // Use your primary color
      ),
    );
  }
}
