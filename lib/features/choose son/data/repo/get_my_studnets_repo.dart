import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';

class GetMyStudentsRepo {
  final ApiService apiService;

  GetMyStudentsRepo(this.apiService);

  Future<ApiResult<StudentsResponse>> getMyStudents(String parentID) async {
    try {
      final response = await apiService.getMyStudents(parentID);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetMeResponse>> getMe() async {
    try {
      final response = await apiService.getMe();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
