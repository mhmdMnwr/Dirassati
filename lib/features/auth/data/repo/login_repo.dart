import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_request.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_response.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/otp_request.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/otp_response.dart';
import 'package:dirasati/features/auth/data/model/reset_password_request.dart';
import 'package:dirasati/features/auth/data/model/verify_otp_request.dart';

class LoginRepo {
  final ApiService apiService;

  LoginRepo(this.apiService);

  Future<ApiResult<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final response = await apiService.login(loginRequest);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<OtpResponse>> otpRequest(OtpRequest sendOtpReq) async {
    try {
      final response = await apiService.sendOtp(sendOtpReq);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<OtpResponse>> verifyOtp(VerifyOtpRequest verifyOtp) async {
    try {
      final response = await apiService.verifyOtp(verifyOtp);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LoginResponse>> resetPassword(
      ResetPasswordRequest resetPassword) async {
    try {
      final response = await apiService.resetPassword(resetPassword);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
