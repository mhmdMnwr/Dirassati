import 'package:dirasati/features/marks/ui/widget/semester_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemesterDetailPage extends StatelessWidget {
  const SemesterDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final grades = [
      SubjectGrade(subject: 'Arabic', cc: 15, test1: 15, test2: 15, exam: 15),
      SubjectGrade(subject: 'Math', cc: 16, test1: 16, test2: 16, exam: 16),
      SubjectGrade(
          subject: 'Genie civil', cc: 15, test1: 15, test2: 15, exam: 15),
      SubjectGrade(subject: 'Islamic', cc: 15, test1: 15, test2: 15, exam: 15),
      SubjectGrade(subject: 'French', cc: 15, test1: 15, test2: 15, exam: 15),
      SubjectGrade(subject: 'English', cc: 15, test1: 15, test2: 15, exam: 15),
      SubjectGrade(subject: 'His/Geo', cc: 15, test1: 15, test2: 15, exam: 15),
      SubjectGrade(subject: 'Sport', cc: 15, test1: 15, test2: 15, exam: 15),
    ];

    return Builder(
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.only(right: 15.w, left: 15.w, top: 100.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: SizedBox(
          width: 500.w,
          height: 660.h,
          child: ListView(
            children: [
              // The 2024/2025 Semester 01 card
              SemesterDetailCard(
                year: '2024/2025',
                semester: 'Semester 01',
                grades: grades,
              ),

              // You can stack more year cards below, like in your first screen:
              // YearCard(year: AcademicYear(title: '2023/2024')), ...
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectGrade {
  final String subject;
  final int cc, test1, test2, exam;

  SubjectGrade({
    required this.subject,
    required this.cc,
    required this.test1,
    required this.test2,
    required this.exam,
  });

  double get avg => (cc + test1 + test2 + exam) / 4;
}
