import 'package:dirasati/core/Networking/dio_factory.dart';
import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
// import 'package:dirasati/features/auth/data/model/login%20Model/login_request.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_response.dart';
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
    
    // Add a delay to simulate network request
    await Future.delayed(const Duration(seconds: 2));
    
    // Check for dummy credentials
    final email = emailController.text.trim();
    final password = passwordController.text;
    
    // Dummy authentication - accept any email/password combination
    if (email.isNotEmpty && password.isNotEmpty) {
      // Create dummy login response
      final dummyResponse = LoginResponse(
        tokens: Tokens(
          accessToken: 'dummy_access_token_123456789',
          refreshToken: 'dummy_refresh_token_987654321',
        ),
        message: 'Login successful',
      );
      
      await saveUserToken(
        dummyResponse.tokens.accessToken,
        dummyResponse.tokens.refreshToken,
      );
      
      emit(LoginState.success(dummyResponse));
    } else {
      emit(const LoginState.error(error: 'Please enter email and password'));
    }
    
    // Comment out the original API call
    /*
    final response = await _loginRepo.login(
      LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
    response.when(success: (loginResponse) async {
      await saveUserToken(
        loginResponse.tokens.accessToken,
        loginResponse.tokens.refreshToken,
      );

      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
    */
  }

  Future<void> saveUserToken(String accessToken, String refreshToken) async {
    await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.accessToken, accessToken);

    await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.refreshToken, refreshToken);
    DioFactory.setTokenIntoHeaderAfterLogin(accessToken);
  }

  void emitForgetPasswordStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.otpRequest(
      OtpRequest(email: emailController.text.trim()),
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
      VerifyOtpRequest(
          email: emailController.text.trim(), otp: otpController.text),
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
          email: emailController.text.trim(),
          newPassword: resetPasswordController.text),
    );
    response.when(success: (_) {
      emit(const LoginState.success(''));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}
