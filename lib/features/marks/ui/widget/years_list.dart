import 'package:dirasati/features/marks/ui/widget/years_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YearModel {
  final String year;
  bool isExpanded;

  YearModel({required this.year, this.isExpanded = false});
}

class YearsList extends StatefulWidget {
  const YearsList({super.key});

  @override
  State<YearsList> createState() => _YearsListState();
}

class _YearsListState extends State<YearsList> {
  late List<YearModel> years;

  @override
  void initState() {
    super.initState();
    // Replace with your real data
    years = List.generate(
      5,
      (index) => YearModel(
        year: '202${0 + index}/202${1 + index}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          return YearsColumn(
            model: years[index],
            onTap: () {
              setState(() {
                years[index].isExpanded = !years[index].isExpanded;
              });
            },
          );
        },
      ),
    );
  }
}
