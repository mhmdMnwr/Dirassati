import 'package:dirasati/core/helpers/date_formatter.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildJustificationTitle extends StatelessWidget {
  final String subjectName;
  final DateTime? absentSinceDate;
  const BuildJustificationTitle(
      {super.key, required this.subjectName, required this.absentSinceDate});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        verticalSpace(10),
        Image.asset(
          IconsManager.absent,
          width: 100.w,
          height: 100.h,
        ),
        horizontalSpace(20),
        Text(
          subjectName,
          style: TextStyles.font22BlackBold,
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            left: isRtl ? 30.w : 0,
            right: isRtl ? 0 : 30.w,
          ),
          child: Text(
            DateFormatterHelper.fomatedDate(absentSinceDate!),
            style: TextStyles.font16BlackBold,
          ),
        ),
      ],
    );
  }
}
