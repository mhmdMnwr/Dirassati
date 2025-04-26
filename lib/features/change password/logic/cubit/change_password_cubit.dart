import 'package:dirasati/core/Networking/dio_factory.dart';
import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/features/change%20password/data/model/change_password_request.dart';
import 'package:dirasati/features/change%20password/data/model/repo/change_password_repo.dart';
import 'package:dirasati/features/change%20password/logic/cubit/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepo _changePasswordRepo;
  ChangePasswordCubit(this._changePasswordRepo)
      : super(ChangePasswordState.initial());

  void changePassword(
      {required ChangePasswordRequest changePasswordRequest}) async {
    emit(ChangePasswordState.loading());
    final response =
        await _changePasswordRepo.changePassword(changePasswordRequest);

    response.when(success: (data) async {
      await saveUserToken(
        data.tokens.accessToken,
        data.tokens.refreshToken,
      );
      emit(ChangePasswordState.success(data));
    }, failure: (error) {
      emit(ChangePasswordState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  Future<void> saveUserToken(String accessToken, String refreshToken) async {
    await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.accessToken, accessToken);

    await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.refreshToken, refreshToken);
    DioFactory.setTokenIntoHeaderAfterLogin(accessToken);
  }
}
