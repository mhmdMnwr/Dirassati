import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/marks/ui/semester_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemestreCard extends StatelessWidget {
  final int index;
  const SemestreCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const SemesterDetailPage(),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Container(
          width: 264.w,
          height: 77.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: ColorsManager.skyBlue,
              width: 2.sp,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Semester 0${index + 1}',
              style: TextStyles.font24BlackBold,
            ),
          ),
        ),
      ),
    );
  }
}
