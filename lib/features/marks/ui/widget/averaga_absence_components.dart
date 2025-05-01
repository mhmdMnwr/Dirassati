import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AverageAbsenceComponents {
  static Widget avrgeButton({double average = 12.40}) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          height: 60.h,
          width: 190.w,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
              child: Text('Average : ${average.toStringAsFixed(2)}',
                  style: TextStyles.font16Whitebold)),
        ));
  }

  static Widget fundamentalAvregeText({double fAverege = 12.10}) {
    return Row(
      children: [
        Text(
          'Fundamental Average',
          style: TextStyles.font16BlackBold,
        ),
        Text(
          ' : ${fAverege.toStringAsFixed(2)}',
          style: TextStyles.font14BlueSemiBold,
        ),
      ],
    );
  }

  static Widget numberOfAbsenceText({int numOfAbc = 10}) {
    return Row(
      children: [
        Text(
          'Number Of Absence',
          style: TextStyles.font16BlackBold,
        ),
        Text(
          ' : $numOfAbc',
          style: TextStyles.font14BlueSemiBold,
        ),
      ],
    );
  }
}
