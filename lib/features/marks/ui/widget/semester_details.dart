import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/marks/ui/semester_details_page.dart';
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
        padding: EdgeInsets.only(left: 16.w),
        child: Column(
          children: [
            // Title + close button
            SemesterPageTitle(),
            verticalSpace(35),
            // Grades table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GradesTable(grades: grades),
            ),

            verticalSpace(35),

            // “Average” button
            avrgeButton(),
          ],
        ),
      ),
    );
  }

  Widget avrgeButton() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          height: 60.h,
          width: 190.w,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
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
              child: Text('Average : 12.4', style: TextStyles.font16Whitebold)),
        ));
  }
}
