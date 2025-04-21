import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class YearCard extends StatelessWidget {
//   final String yearText;
//   const YearCard({super.key, required this.yearText});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 310.w,
//       height: 77.h,
//       decoration: BoxDecoration(
//         color: ColorsManager.skyBlue,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4.r,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Center(
//         child: Text(yearText, style: TextStyles.font24WhiteSemiBold),
//       ),
//     );
//   }
// }
class YearCard extends StatelessWidget {
  final String yearText;

  const YearCard({super.key, required this.yearText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310.w,
      height: 77.h,
      decoration: BoxDecoration(
        color: ColorsManager.skyBlue,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Center(
        child: Text(yearText, style: TextStyles.font24WhiteSemiBold),
      ),
    );
  }
}
