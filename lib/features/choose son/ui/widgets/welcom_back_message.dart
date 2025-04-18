import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomBackMessage extends StatelessWidget {
  final String parentName;
  const WelcomBackMessage({required this.parentName, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 150.h,
        left: 16.w,
        bottom: 100.h,
      ),
      child: Row(
        children: [
          verticalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyles.font14BlueSemiBold,
                ),
                Text(
                  parentName,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font24SecBlueExtraBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
