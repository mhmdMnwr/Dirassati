import 'package:dirasati/features/justification/data/repo/steudent_absence_repo.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  final GetStudentAbsenceRepo _getStudentAbsenceRepo;

  AbsenceCubit(this._getStudentAbsenceRepo)
      : super(const AbsenceState.initial());

  void getStudentAbsence({required String studentId}) async {
    emit(const AbsenceState.loading());
    final response = await _getStudentAbsenceRepo.getStudentAbsence(studentId);
    response.when(success: (absenceData) {
      emit(AbsenceState.success(absenceData));
    }, failure: (error) {
      emit(AbsenceState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
