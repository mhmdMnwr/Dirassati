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
          _cell('AVG', headerStyle),
        ],
      ),
    ];

    // Data rows
    for (var g in grades) {
      rows.add(TableRow(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(g.subject),
        ),
        // vertical blue bar + cc value
        Row(
          children: [
            Container(width: 4, height: 20, color: Colors.blue),
            SizedBox(width: 6),
            Text(g.cc.toString()),
          ],
        ),
        _cell(g.test1.toString()),
        _cell(g.test2.toString()),
        _cell(g.exam.toString()),
        Text(g.avg.toStringAsFixed(0),
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
      ]));
    }

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FixedColumnWidth(100.w),
        1: FixedColumnWidth(60.w),
        2: FixedColumnWidth(60.w),
        3: FixedColumnWidth(60.w),
        4: FixedColumnWidth(60.w),
        5: FixedColumnWidth(60.w),
      },
      children: rows,
    );
  }

  Widget _cell(String text, [TextStyle? style]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: style),
    );
  }
}
