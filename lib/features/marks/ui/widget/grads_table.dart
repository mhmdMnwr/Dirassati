import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/features/marks/data/model/marks_model.dart';
import 'package:dirasati/features/marks/marks_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradesTable extends StatelessWidget {
  final GetMarksResponse? marks;
  const GradesTable({super.key, required this.marks});

  @override
  Widget build(BuildContext context) {
    // Header row
    final headerStyle = TextStyle(fontWeight: FontWeight.bold);
    List<TableRow> rows = [
      TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          SizedBox(), // empty top-left
          _cell(MarksConsts.cc, headerStyle),
          _cell(MarksConsts.test1, headerStyle),
          _cell(MarksConsts.test2, headerStyle),
          _cell(MarksConsts.exam, headerStyle),
          _cell(MarksConsts.coeff, headerStyle),
          _cell(MarksConsts.avg, headerStyle),
        ],
      ),
    ];

    // Data rows
    for (var g in (marks?.data ?? [])) {
      late final String secondTest;
      if (!(g.subject.isMain)) {
        secondTest = '/';
      } else {
        secondTest = g.secondTest.toString();
      }

      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(g.subject?.name ?? ''),
        ),
        Row(
          children: [
            Container(width: 4.w, height: 20.h, color: Colors.blue),
            horizontalSpace(6),
            Text(g.noteCC.toString()),
          ],
        ),
        _cell(g.firstTest.toString()),
        _cell(secondTest),
        _cell(g.subject!.coefficient.toString()),
        _cell(g.exam.toString()),
        Text(g.calculateSubjectaverage.toStringAsFixed(2),
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
