import 'package:dirasati/features/auth/data/model/login%20Model/login_request.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/otp_request.dart';
import 'package:dirasati/features/auth/data/model/reset_password_request.dart';
import 'package:dirasati/features/auth/data/model/verify_otp_request.dart';
import 'package:dirasati/features/auth/data/repo/login_repo.dart';
import 'package:dirasati/features/auth/logic/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(success: (loginResponse) async {
      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  void emitForgetPasswordStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.otpRequest(
      OtpRequest(email: emailController.text),
    );
    response.when(success: (_) {
      emit(const LoginState.success(''));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  TextEditingController otpController = TextEditingController();

  void emitVerifyOtpState() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.verifyOtp(
      VerifyOtpRequest(email: emailController.text, otp: otpController.text),
    );
    response.when(success: (_) {
      emit(const LoginState.success(''));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  TextEditingController resetPasswordController = TextEditingController();

  void emitResetPasswordState() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.resetPassword(
      ResetPasswordRequest(
          email: emailController.text,
          newPassword: resetPasswordController.text),
    );
    response.when(success: (_) {
      emit(const LoginState.success(''));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
