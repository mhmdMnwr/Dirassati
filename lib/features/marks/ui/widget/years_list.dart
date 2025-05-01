import 'package:dirasati/features/marks/ui/widget/years_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YearListModel {
  final String year;
  bool isExpanded;
  int trimestersCount; // Add this line to initialize semestersCount

  YearListModel(
      {required this.year,
      this.isExpanded = false,
      required this.trimestersCount});
}

class YearsList extends StatefulWidget {
  final String studentId;
  final List<YearListModel> yearsList;
  const YearsList(
      {super.key, required this.yearsList, required this.studentId});

  @override
  State<YearsList> createState() => _YearsListState();
}

class _YearsListState extends State<YearsList> {
  late final List<YearListModel> yearsList;

  @override
  void initState() {
    super.initState();
    yearsList = widget.yearsList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: ListView.builder(
        itemCount: yearsList.length,
        itemBuilder: (context, index) {
          return YearsColumn(
            studentId: widget.studentId,
            model: yearsList[index],
            onTap: () {
              setState(() {
                yearsList[index].isExpanded = !yearsList[index].isExpanded;
              });
            },
          );
        },
      ),
    );
  }
}
