import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildJustificationTitle extends StatelessWidget {
  final String subjectName;
  const BuildJustificationTitle({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 10,
        ),
        Image.asset(
          IconsManager.absent,
          width: 100.w,
          height: 100.h,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          subjectName,
          style: TextStyles.font22BlackBold,
        )
      ],
    );
  }
}
