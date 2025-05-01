import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/features/marks/ui/semester_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradesTable extends StatelessWidget {
  final List<SubjectGrade> grades;
  const GradesTable({super.key, required this.grades});

  @override
  Widget build(BuildContext context) {
    // Header row
    final headerStyle = TextStyle(fontWeight: FontWeight.bold);
    List<TableRow> rows = [
      TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          SizedBox(), // empty top-left
          _cell('cc', headerStyle),
          _cell('Test\n 01', headerStyle),
          _cell('Test\n 02', headerStyle),
          _cell('Exam', headerStyle),
          _cell('Coeff', headerStyle),
          _cell('AVG', headerStyle),
        ],
      ),
    ];

    // Data rows
    for (var g in grades) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(g.subject),
        ),
        // vertical blue bar + cc value
        Row(
          children: [
            Container(width: 4.w, height: 20.h, color: Colors.blue),
            horizontalSpace(6),
            Text(g.cc.toString()),
          ],
        ),
        _cell(g.test1.toString()),
        _cell(g.test2.toString()),
        _cell(g.coefficient.toString()),
        _cell(g.exam.toString()),
        Text(g.avg.toStringAsFixed(2),
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
      ]));
    }

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FixedColumnWidth(120.w),
        1: FixedColumnWidth(60.w),
        2: FixedColumnWidth(60.w),
        3: FixedColumnWidth(60.w),
        4: FixedColumnWidth(60.w),
        5: FixedColumnWidth(60.w),
        6: FixedColumnWidth(60.w),
      },
      children: rows,
    );
  }

  Widget _cell(String text, [TextStyle? style]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Text(text, style: style),
    );
  }
}
