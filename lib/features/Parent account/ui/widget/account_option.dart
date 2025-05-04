import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/notification_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountOption extends StatelessWidget {
  final bool isNotification;
  final String icon;
  final String title;
  final VoidCallback onTap;

  const AccountOption({
    this.isNotification = false,
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
        child: SizedBox(
          height: 100.h,
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(icon, height: 50.h, width: 50.w),
                  if (isNotification) NotificationCircle(notificationCount: 5),
                ],
              ),
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
