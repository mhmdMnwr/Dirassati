import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/schedule/ui/widget/schedule_button.dart';
import 'package:dirasati/generated/app_localizations.dart';
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
              onTap: () => _idkHowToNameThisFunction(
                  context,
                  AppLocalizations.of(context)!.daily_schedule,
                  student.classa?.planning ?? ''),
              scheduleIcon: IconsManager.dailySchedule,
              scheduleTitle: AppLocalizations.of(context)!.daily_schedule),
          verticalSpace(80),
          ScheduleButton(
              onTap: () => _idkHowToNameThisFunction(
                  context,
                  AppLocalizations.of(context)!.exam_schedule,
                  student.classa?.examPlanning ?? ''),
              scheduleIcon: IconsManager.examSchedule,
              scheduleTitle: AppLocalizations.of(context)!.exam_schedule),
        ],
      ),
    );
  }

  void _idkHowToNameThisFunction(
    BuildContext context,
    String scheduleTitle,
    String url,
  ) {
    if (url != "") {
      _showDialog(context, scheduleTitle, url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.schedule_not_available),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDialog(BuildContext context, String scheduleTitle, String url) {
    context.pushNamed(Routes.pdfPage, arguments: {
      'pdfUrl': url,
      'pdfName': scheduleTitle,
    });
  }
}
