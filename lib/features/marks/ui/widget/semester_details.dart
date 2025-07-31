import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/features/marks/data/model/marks_model.dart';
import 'package:dirasati/features/marks/ui/widget/averaga_absence_components.dart';
import 'package:dirasati/features/marks/ui/widget/grads_table.dart';
import 'package:dirasati/features/marks/ui/widget/semester_page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemesterDetailCard extends StatelessWidget {
  final String year;
  final String trimestre;
  final GetMarksResponse? marks;

  const SemesterDetailCard(
      {super.key,
      required this.year,
      required this.trimestre,
      required this.marks});

  // Removed avg initialization from here

  @override
  Widget build(BuildContext context) {
    final double avg = marks?.totalAvg ?? 0.0;
    final int absence = marks?.totalAbsence ?? 0;
    final double mainAvg = marks?.isMainAvg ?? 0.0;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          left:
              Directionality.of(context).toString().contains('rtl') ? 0 : 20.w,
          right:
              Directionality.of(context).toString().contains('rtl') ? 20.w : 0,
        ),
        child: Column(
          children: [
            // Title + close button
            SemesterPageTitle(year: year, trimestre: trimestre),
            verticalSpace(30),
            // Grades table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GradesTable(
                marks: marks,
              ),
            ),

            verticalSpace(15),

            AverageAbsenceComponents.fundamentalAvregeText(
                fAverege: mainAvg, context: context),
            verticalSpace(20),
            AverageAbsenceComponents.numberOfAbsenceText(
                numOfAbc: absence, context: context),
            verticalSpace(20),
            AverageAbsenceComponents.avrgeButton(
                average: avg, context: context),
          ],
        ),
      ),
    );
  }
}
