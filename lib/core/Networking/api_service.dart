import 'package:dio/dio.dart';
import 'package:dirasati/core/Networking/api_constants.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_request.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_response.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/otp_request.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/standard_response.dart';
import 'package:dirasati/features/auth/data/model/reset_password_request.dart';
import 'package:dirasati/features/auth/data/model/verify_otp_request.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/data/model/send_justification_response.dart';
import 'package:dirasati/features/parent%20info/data/model/update_parent_request.dart';
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
  Future<StandardResponse> sendOtp(
    @Body() OtpRequest otpRequest,
  );

  @POST(ApiConstants.verifyOtp)
  Future<StandardResponse> verifyOtp(
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
  @GET("${ApiConstants.getStudentAbsence}/{studentId}")
  Future<AbsenceResponse> getStudentAbsence(
    @Path("studentId") String studentId,
  );

  @POST(ApiConstants.sendJustification)
  Future<SendJustificationResponse> sendJustification(
    @Body() SendJustificationRequest sendJustificationRequest,
  );

  @GET(ApiConstants.getMe)
  Future<GetMeResponse> getMe();

  @PATCH("${ApiConstants.updateParent}/{parentId}")
  Future<GetMeResponse> updateParent(
    @Path("parentId") String parentId,
    @Body() UpdateParentRequest updatedParent,
  );
}
