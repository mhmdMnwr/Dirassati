import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/schedule/ui/widget/schedule_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScheduleButton(
              scheduleIcon: IconsManager.schedule,
              scheduleTitle: 'Daily Schedule'),
          verticalSpace(80),
          ScheduleButton(
              scheduleIcon: IconsManager.schedule,
              scheduleTitle: 'Exam Schedule'),
        ],
      ),
    );
  }
}
