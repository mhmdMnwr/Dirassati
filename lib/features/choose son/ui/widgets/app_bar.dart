import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment.start;
    return Padding(
      padding: EdgeInsets.only(
        top: 30.h,
        left: 16.w,
      ),
      child: Row(
        children: [
          Image.asset(
            IconsManager.logo,
            height: 50.h,
            width: 50.w,
          ),
          Text(
            'Dirassati',
            style: TextStyles.font24SkyBlueExtraBold,
          ),
        ],
      ),
    );
  }
}
