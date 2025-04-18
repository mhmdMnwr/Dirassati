import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewWidget extends StatelessWidget {
  final Student student;

  const ListViewWidget({required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 200.h,
      ),
      child: Container(
        height: 150.h,
        width: 240.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 3,
              offset: const Offset(6, 7),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 12.w, right: 12.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: ColorsManager.lighterGray,
                    child: Image.asset(
                      IconsManager.person,
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                  verticalSpace(10),
                  Flexible(
                    // Allows the text to wrap properly
                    child: Text(
                      '${student.firstName} ${student.lastName}',
                      style: TextStyles.font16BlackBold,
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 25.w,
              right: 20.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    getLevelImage(int.parse(student.level.substring(0, 1))),
                    width: 113.w,
                    height: 169.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.w),
                    child: RotatedBox(
                      quarterTurns: 3, // 1 turn = 90 degrees
                      child: Text("Primary",
                          style: TextStyles.font24darGraykSeliBold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getLevelImage(int level) {
    switch (level) {
      case 1:
        return IconsManager.number1;
      case 2:
        return IconsManager.number2;
      case 3:
        return IconsManager.number3;
      case 4:
        return IconsManager.number4;
      case 5:
        return IconsManager.number5;
      default:
        return IconsManager.number1;
    }
  }
}
