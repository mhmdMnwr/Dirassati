import 'package:bloc/bloc.dart';
import 'package:dirasati/features/HomeWork/data/repo/home_work_repo.dart';
import 'package:dirasati/features/HomeWork/logic/cubit/home_work_state.dart';

class HomeWorkCubit extends Cubit<HomeWorkState> {
  final HomeWorkRepository _homeWorkRepository;

  HomeWorkCubit(this._homeWorkRepository) : super(HomeWorkState.initial());

  void getHomeWorkData({required String studentId}) async {
    emit(HomeWorkState.loading());
    final response = await _homeWorkRepository.getHomeWork(studentId);
    response.when(success: (homeWorkResponse) {
      emit(HomeWorkState.loaded(homeWorkResponse));
    }, failure: (error) {
      emit(HomeWorkState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
