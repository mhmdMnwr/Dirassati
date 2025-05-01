import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/features/marks/ui/semester_details_page.dart';
import 'package:dirasati/features/marks/ui/widget/averaga_absence_components.dart';
import 'package:dirasati/features/marks/ui/widget/grads_table.dart';
import 'package:dirasati/features/marks/ui/widget/semester_page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemesterDetailCard extends StatelessWidget {
  final String year;
  final String semester;
  final List<SubjectGrade> grades;

  const SemesterDetailCard({
    super.key,
    required this.year,
    required this.semester,
    required this.grades,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          children: [
            // Title + close button
            SemesterPageTitle(),
            verticalSpace(30),
            // Grades table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GradesTable(grades: grades),
            ),

            verticalSpace(15),

            AverageAbsenceComponents.fundamentalAvregeText(),
            verticalSpace(20),
            AverageAbsenceComponents.numberOfAbsenceText(),
            verticalSpace(20),
            AverageAbsenceComponents.avrgeButton(average: 12.40),
          ],
        ),
      ),
    );
  }
}
