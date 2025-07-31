// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dirasati/features/paiment/data/model/paiment_model.dart';
import 'package:dirasati/features/paiment/data/repo/paiment_repo.dart';
import 'package:dirasati/features/paiment/logic/cubit/paiment_state.dart';

class PaimentCubit extends Cubit<PaimentState> {
  // ignore: unused_field
  final PaimentRepo _paimentRepo;
  PaimentCubit(this._paimentRepo) : super(const PaimentState.initial());

  void getMyPaiment() async {
    emit(PaimentState.loading());
    
    // Add delay to simulate network request
    await Future.delayed(const Duration(seconds: 2));
    
    // Create dummy payment data
    final dummyPayments = PaimentResponse(
      success: true,
      data: [
        PaimentModel(
          id: 'payment_1',
          student: PayStudent(
            firstName: 'سارة', // Sarah
            lastName: 'أحمد', // Ahmed
            level: 'primary',
          ),
          amount: 2500,
          paidAmount: 1500,
          nextPaymentAmount: 1000,
          nextPaymentDate: DateTime.now().add(const Duration(days: 15)),
          paymentMode: 'quarterly',
        ),
        PaimentModel(
          id: 'payment_2',
          student: PayStudent(
            firstName: 'محمد', // Mohammed
            lastName: 'علي', // Ali
            level: 'primary',
          ),
          amount: 3000,
          paidAmount: 3000,
          nextPaymentAmount: 0,
          nextPaymentDate: DateTime.now().add(const Duration(days: 45)),
          paymentMode: 'quarterly',
        ),
        PaimentModel(
          id: 'payment_3',
          student: PayStudent(
            firstName: 'فاطمة', // Fatima
            lastName: 'حسن', // Hassan
            level: 'middle',
          ),
          amount: 2200,
          paidAmount: 0,
          nextPaymentAmount: 2200,
          nextPaymentDate: DateTime.now().add(const Duration(days: 7)),
          paymentMode: 'quarterly',
        ),
      ],
    );
    
    emit(PaimentState.paimentLoaded(dummyPayments));
    
    // Comment out the original API call
    /*
    final responde = await _paimentRepo.getPaiment();
    responde.when(success: (paimentResponse) {
      emit(PaimentState.paimentLoaded(paimentResponse));
    }, failure: (error) {
      emit(PaimentState.error(error: error.apiErrorModel.message ?? ''));
    });
    */
  }
}
