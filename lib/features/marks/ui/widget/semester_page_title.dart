import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemesterPageTitle extends StatelessWidget {
  final String year;
  final String trimestre;
  const SemesterPageTitle(
      {super.key, required this.year, required this.trimestre});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.close,
              size: 35.sp,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        Text(
          year,
          style: TextStyles.font14GrayRegular,
        ),
        verticalSpace(5.h), // Add space instead of Expanded
        Text(
          trimestre,
          style: TextStyles.font30BlackBold,
        ),
      ],
    );
  }
}
