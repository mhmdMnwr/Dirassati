import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/schedule/ui/widget/schedule_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SchedulePage extends StatelessWidget {
  final Student student;
  const SchedulePage({super.key, required this.student});

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
              onTap: () => _showDialog(
                  context, 'Daily Schedule', student.classa?.planning ?? ''),
              scheduleIcon: IconsManager.dailySchedule,
              scheduleTitle: 'Daily Schedule'),
          verticalSpace(80),
          ScheduleButton(
              onTap: () => _showDialog(context, 'Exam Schedule', ''),
              scheduleIcon: IconsManager.examSchedule,
              scheduleTitle: 'Exam Schedule'),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String scheduleTitle, String url) {
    context.pushNamed(Routes.pdfPage, arguments: {
      //TODO : Update this to use the correct URL from your API
      'pdfUrl': url,
      'pdfName': scheduleTitle,
    });
  }
}
