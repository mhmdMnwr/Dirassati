import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BuildJustificationTitle extends StatelessWidget {
  final String subjectName;
  final DateTime? absentSinceDate;
  const BuildJustificationTitle(
      {super.key, required this.subjectName, required this.absentSinceDate});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy\nHH:mm');
    String formatted = formatter.format(absentSinceDate!);
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
          padding: EdgeInsets.only(right: 30.w),
          child: Text(
            formatted,
            style: TextStyles.font16BlackBold,
          ),
        ),
      ],
    );
  }
}
