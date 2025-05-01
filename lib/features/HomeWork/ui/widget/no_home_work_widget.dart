import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoHomeWork extends StatelessWidget {
  const NoHomeWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalSpace(100),
        Image.asset(IconsManager.noHomeWork),
        verticalSpace(10),
        Text(
          'No Home Work',
          style: TextStyles.font22BlackBold,
          textAlign: TextAlign.center,
        ),
        Text(
          'For Now',
          style: TextStyles.font22BlackBold,
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Image.asset(IconsManager.noHomeWorkBackground),
        ),
      ],
    );
  }
}
