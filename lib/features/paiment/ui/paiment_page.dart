import 'package:dirasati/features/paiment/data/model/paiment_model.dart';
import 'package:dirasati/features/paiment/ui/widgets/app_bar.dart';
import 'package:dirasati/features/paiment/ui/widgets/student_list_view_builder.dart';
import 'package:flutter/material.dart';

class PaimentPage extends StatelessWidget {
  PaimentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        PaymentAppBar(
          nextPaymentDate: '14/05/2025',
          title: "TUITION FEES",
          totalPayed: '15000 DZD',
          totalToPay: '30000 DZD',
        ),
        Expanded(
          child: StudentListViewBuilder(
            paiments: paimentResponse.data ?? [],
          ),
        )
      ],
    ));
  }

  final paimentResponse = PaimentResponse(
    success: true,
    data: [
      PaimentModel(
        id: '1',
        student: PayStudent(
          firstName: 'Ali',
          lastName: 'Ben Salah',
          level: 'Grade 5',
        ),
        amount: 30000,
        paymentMode: 'quarterly',
        paidAmount: 10000,
        nextPaymentAmount: 7500,
        nextPaymentDate: DateTime(2025, 8, 26),
      ),
      PaimentModel(
        id: '2',
        student: PayStudent(
          firstName: 'Sara',
          lastName: 'Khaled',
          level: 'Grade 6',
        ),
        amount: 32000,
        paymentMode: 'monthly',
        paidAmount: 12000,
        nextPaymentAmount: 8000,
        nextPaymentDate: DateTime(2025, 9, 10),
      ),
      PaimentModel(
        id: '3',
        student: PayStudent(
          firstName: 'Omar',
          lastName: 'Mansour',
          level: 'Grade 4',
        ),
        amount: 28000,
        paymentMode: 'quarterly',
        paidAmount: 7000,
        nextPaymentAmount: 7000,
        nextPaymentDate: DateTime(2025, 7, 15),
      ),
      PaimentModel(
        id: '4',
        student: PayStudent(
          firstName: 'Maya',
          lastName: 'Fathi',
          level: 'Grade 3',
        ),
        amount: 25000,
        paymentMode: 'monthly',
        paidAmount: 5000,
        nextPaymentAmount: 6000,
        nextPaymentDate: DateTime(2025, 10, 5),
      ),
      PaimentModel(
        id: '5',
        student: PayStudent(
          firstName: 'Youssef',
          lastName: 'Hamdi',
          level: 'Grade 2',
        ),
        amount: 20000,
        paymentMode: 'quarterly',
        paidAmount: 4000,
        nextPaymentAmount: 5000,
        nextPaymentDate: DateTime(2025, 11, 20),
      ),
    ],
  );
}
