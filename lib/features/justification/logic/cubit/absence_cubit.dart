import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/data/model/send_update_justification_request.dart';
import 'package:dirasati/features/justification/data/repo/steudent_absence_repo.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  final GetStudentAbsenceRepo _getStudentAbsenceRepo;

  AbsenceCubit(
    this._getStudentAbsenceRepo,
  ) : super(const AbsenceState.initial());

  void getStudentAbsence({required String studentId}) async {
    emit(const AbsenceState.loading());
    final response = await _getStudentAbsenceRepo.getStudentAbsence(studentId);
    response.when(success: (absenceResponse) {
      emit(AbsenceState.loaded(absenceResponse));
    }, failure: (error) {
      emit(AbsenceState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  void sendJustification(
      {required SendJustificationRequest sendJustificationRequest}) async {
    emit(const AbsenceState.sending());
    final response = await _getStudentAbsenceRepo
        .sendJustification(sendJustificationRequest);
    response.when(success: (data) {
      emit(AbsenceState.sendSuccess(data));
    }, failure: (error) {
      emit(AbsenceState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  void updateJustification(
      {required String justificationId,
      required SendUpdateJustificationRequest
          sendUpdateJustificationRequest}) async {
    emit(const AbsenceState.sending());
    final response = await _getStudentAbsenceRepo.updateJustification(
        justificationId, sendUpdateJustificationRequest);
    response.when(success: (data) {
      emit(AbsenceState.sendSuccess(data));
    }, failure: (error) {
      emit(AbsenceState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
