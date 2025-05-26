// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:dirasati/features/paiment/data/repo/paiment_repo.dart';
import 'package:dirasati/features/paiment/logic/cubit/paiment_state.dart';

class PaimentCubit extends Cubit<PaimentState> {
  PaimentRepo _paimentRepo;

  PaimentCubit(
    this._paimentRepo,
  ) : super(PaimentState.initial());

  void getMyPaiment() async {
    emit(PaimentState.loading());
    final responde = await _paimentRepo.getPaiment();
    responde.when(success: (paimentResponse) {
      emit(PaimentState.paimentLoaded(paimentResponse));
    }, failure: (error) {
      emit(PaimentState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
