import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCircle extends StatelessWidget {
  final int notificationCount;
  const NotificationCircle({super.key, required this.notificationCount});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -2.h,
      right: -2.w,
      child: Container(
        height: 22.h,
        width: 22.h,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1.sp,
          ),
        ),
        child: Center(
          child: Text(
            '$notificationCount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
