import 'package:bloc/bloc.dart';
import 'package:dirasati/features/marks/data/repo/marks_repo.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_state.dart';

class MarksCubit extends Cubit<MarksState> {
  final MarksRepository _marksRepository;
  MarksCubit(this._marksRepository) : super(MarksState.initial());

  void getYears({required String studentId}) async {
    emit(MarksState.loading());
    final response = await _marksRepository.getStudentyears(studentId);
    response.when(success: (yearsResponse) {
      emit(MarksState.yearsloaded(yearsResponse));
    }, failure: (error) {
      emit(MarksState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  void getMarks({required studentId, required year, required trimestre}) async {
    emit(MarksState.marksLoading());
    final validYear = year.replaceAll('/', '%2F');
    final response =
        await _marksRepository.getStudentMarks(studentId, validYear, trimestre);
    response.when(success: (marksResponse) {
      emit(MarksState.marksLoaded(marksResponse));
    }, failure: (error) {
      emit(MarksState.marksError(error: error.apiErrorModel.message ?? ''));
    });
  }
}
