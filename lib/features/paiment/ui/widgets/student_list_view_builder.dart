// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dirasati/features/paiment/data/model/paiment_model.dart';
import 'package:dirasati/features/paiment/ui/widgets/List_view_item.dart';

class StudentListViewBuilder extends StatelessWidget {
  final List<PaimentModel>? paiments;
  const StudentListViewBuilder({
    super.key,
    required this.paiments,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: paiments?.length ?? 0, // Ensure we handle null or empty lists
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            right: 16.w,
            left: 16.w,
          ),
          child: PayStudentCard(
            paiment: paiments?[index] ??
                PaimentModel(
                  id: '0',
                  student: null,
                  amount: 0,
                  paymentMode: '',
                  paidAmount: 0,
                  nextPaymentAmount: 0,
                  nextPaymentDate: DateTime.now(),
                ),
          ),
        );
      },
    );
  }
}
