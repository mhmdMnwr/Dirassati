import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/features/auth/data/model/otp%20Model/standard_response.dart';

import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';

class GetStudentAbsenceRepo {
  final ApiService apiService;

  GetStudentAbsenceRepo(this.apiService);

  Future<ApiResult<AbsenceResponse>> getStudentAbsence(String studentId) async {
    try {
      final response = await apiService.getStudentAbsence(studentId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<StandardResponse>> sendJustification(
      SendJustificationRequest sendJustificationRequest) async {
    try {
      final response =
          await apiService.sendJustification(sendJustificationRequest);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
