import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dirasati/features/parent%20info/data/model/update_parent_request.dart';
import 'package:dirasati/features/parent%20info/logic/cubit/update_parent_state.dart';
import 'package:dirasati/features/parent%20info/data/repo/update_repo.dart';

class UpdateParentCubit extends Cubit<UpdateParentState> {
  final UpdateRepo _updateRepo;
  UpdateParentCubit(this._updateRepo) : super(UpdateParentState.initial());

  void updateParent({
    required UpdateParentRequest updatedParent,
  }) async {
    emit(UpdateParentState.loading());
    final response = await _updateRepo.updateParent(
      updatedParent,
    );
    response.when(
      success: (getMeResponse) {
        emit(UpdateParentState.success(getMeResponse));
      },
      failure: (error) {
        emit(UpdateParentState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
