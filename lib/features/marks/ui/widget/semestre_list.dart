import 'package:dirasati/features/marks/ui/widget/semestre_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemestresList extends StatelessWidget {
  final int trimestersCount; // Example semester count
  const SemestresList({super.key, required this.trimestersCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 55.w, left: 55.w, top: 20.h),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trimestersCount,
        itemBuilder: (context, index) {
          return SemestreCard(index: index);
        },
      ),
    );
  }
}
