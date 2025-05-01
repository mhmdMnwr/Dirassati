import 'package:dirasati/features/marks/data/model/marks_model.dart';
import 'package:dirasati/features/marks/ui/widget/semester_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemesterDetailPage extends StatelessWidget {
  final GetMarksResponse? marksResponse;
  final String year;
  final String trimestre;
  const SemesterDetailPage({
    super.key,
    required this.marksResponse,
    required this.year,
    required this.trimestre,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.only(right: 19.w, left: 19.w, top: 40.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: SizedBox(
          width: 500.w,
          height: 780.h,
          child: ListView(
            children: [
              // The 2024/2025 Semester 01 card
              SemesterDetailCard(
                year: year,
                trimestre: trimestre,
                marks: marksResponse,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
