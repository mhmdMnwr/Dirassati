import 'package:bloc/bloc.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/data/repo/steudent_absence_repo.dart';
import 'package:dirasati/features/justification/logic/cubit/justification_state.dart';

class JustificationCubit extends Cubit<JustificationState> {
  final GetStudentAbsenceRepo _getStudentAbsenceRepo;
  JustificationCubit(this._getStudentAbsenceRepo)
      : super(const JustificationState.initial());

  void sendJustification(
      {required SendJustificationRequest sendJustificationRequest}) async {
    emit(const JustificationState.loading());
    final response = await _getStudentAbsenceRepo
        .sendJustification(sendJustificationRequest);
    response.when(success: (data) {
      emit(JustificationState.success(data));
    }, failure: (error) {
      emit(JustificationState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
