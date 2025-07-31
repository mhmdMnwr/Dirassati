import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AverageAbsenceComponents {
  static Widget avrgeButton(
      {double average = 12.40, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 60.h,
            width: 190.w,
            decoration: BoxDecoration(
              color: average >= 10 ? Colors.green : Colors.red,
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
                child: Text(
                    '${AppLocalizations.of(context)!.average} : ${average.toStringAsFixed(2)}',
                    style: TextStyles.font16Whitebold)),
          )),
    );
  }

  static Widget fundamentalAvregeText(
      {double fAverege = 12.10, required BuildContext context}) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.fundamentalAverage,
          style: TextStyles.font16BlackBold,
        ),
        Text(
          ' : ${fAverege.toStringAsFixed(2)}',
          style: TextStyles.font14BlueSemiBold,
        ),
      ],
    );
  }

  static Widget numberOfAbsenceText(
      {int numOfAbc = 10, required BuildContext context}) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.numberOfAbsence,
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
