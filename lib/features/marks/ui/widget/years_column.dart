import 'package:dirasati/features/marks/ui/widget/semestre_list.dart';
import 'package:dirasati/features/marks/ui/widget/year_card.dart';
import 'package:dirasati/features/marks/ui/widget/years_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class YearsColumn extends StatelessWidget {
//   final YearModel model;
//   final VoidCallback onTap;

//   const YearsColumn({super.key, required this.model, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15.h),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Column(
//           children: [
//             YearCard(yearText: model.year),
//             if (model.isExpanded) SemestresList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
class YearsColumn extends StatefulWidget {
  final YearModel model;
  final VoidCallback onTap;

  const YearsColumn({super.key, required this.model, required this.onTap});

  @override
  State<YearsColumn> createState() => _YearsColumnState();
}

class _YearsColumnState extends State<YearsColumn>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YearCard(yearText: widget.model.year),
              if (widget.model.isExpanded) SemestresList(),
            ],
          ),
        ),
      ),
    );
  }
}
