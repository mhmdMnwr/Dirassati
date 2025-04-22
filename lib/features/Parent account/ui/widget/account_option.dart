import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountOption extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const AccountOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
        child: SizedBox(
          height: 100.h,
          child: Row(
            children: [
              Image.asset(icon, height: 50.h, width: 50.w),
              horizontalSpace(16),
              Expanded(
                child: Text(title, style: TextStyles.font16BlackBold),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: Icon(Icons.arrow_forward_ios,
                    color: ColorsManager.mainBlue, size: 20.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
