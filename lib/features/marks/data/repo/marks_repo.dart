import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/marks/data/model/marks_model.dart';
import 'package:dirasati/features/marks/data/model/years_model.dart';

class MarksRepository {
  final ApiService _apiService;
  MarksRepository(this._apiService);

  Future<ApiResult<YearsResponse>> getStudentyears(String studentId) async {
    try {
      final response = await _apiService.getStudentYears(studentId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetMarksResponse>> getStudentMarks(
      String studentId, String yearId, String trimestre) async {
    try {
      final response = await _apiService.getMarks(studentId, yearId, trimestre);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
