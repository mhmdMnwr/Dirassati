import 'package:dio/dio.dart';
import 'package:dirasati/core/Networking/api_constants.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_request.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_response.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/otp_request.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/otp_response.dart';
import 'package:dirasati/features/auth/data/model/reset_password_request.dart';
import 'package:dirasati/features/auth/data/model/verify_otp_request.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequest loginRequest,
  );

  @POST(ApiConstants.sendOtp)
  Future<OtpResponse> sendOtp(
    @Body() OtpRequest otpRequest,
  );

  @POST(ApiConstants.verifyOtp)
  Future<OtpResponse> verifyOtp(
    @Body() VerifyOtpRequest verifyOtpRequest,
  );

  @POST(ApiConstants.resetPassword)
  Future<LoginResponse> resetPassword(
    @Body() ResetPasswordRequest resetPassword,
  );

  @GET("${ApiConstants.getMyStudents}/{parentId}")
  Future<StudentsResponse> getMyStudents(
    @Path("parentId") String parentId,
  );
}
