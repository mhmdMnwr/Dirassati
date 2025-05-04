import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/notification_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAccountIcon extends StatelessWidget {
  final BuildContext context;
  final VoidCallback onTap;

  const BuildAccountIcon({
    super.key,
    required this.context,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 55.h,
              width: 55.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorsManager.mainBlue,
                  width: 3.5.sp,
                ),
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
              child: Center(
                child: Image.asset(
                  IconsManager.person,
                  color: Colors.black,
                  width: 24.h,
                  height: 24.h,
                ),
              ),
            ),
            // Notification badge
           NotificationCircle(
              notificationCount: 5, // Replace with actual count
            ),
          ],
        ),
      ),
    );
  }
}
