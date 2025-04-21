import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildJustificationTitle extends StatelessWidget {
  final String subjectName;
  final DateTime? absentSinceDate;
  const BuildJustificationTitle(
      {super.key, required this.subjectName, required this.absentSinceDate});

  @override
  Widget build(BuildContext context) {
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
        horizontalSpace(20),
        Text(
          '${absentSinceDate!.day}/${absentSinceDate!.month}/${absentSinceDate!.year} ${absentSinceDate!.hour}:${absentSinceDate!.minute}',
          style: TextStyles.font16BlackBold,
        ),
      ],
    );
  }
}
