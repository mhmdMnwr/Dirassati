import 'package:dirasati/features/choose%20son/data/repo/get_my_studnets_repo.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMyStudentsCubit extends Cubit<GetMyStudentsState> {
  final GetMyStudentsRepo _getMyStudentsRepo;

  GetMyStudentsCubit(this._getMyStudentsRepo)
      : super(const GetMyStudentsState.initial());

  void getMyStudents({required String parentId}) async {
    emit(const GetMyStudentsState.loading());
    final response = await _getMyStudentsRepo.getMyStudents(parentId);
    response.when(success: (studentsData) {
      emit(GetMyStudentsState.success(studentsData));
    }, failure: (error) {
      emit(GetMyStudentsState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
