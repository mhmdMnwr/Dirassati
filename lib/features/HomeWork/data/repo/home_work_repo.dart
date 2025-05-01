import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/HomeWork/data/model/home_work_model.dart';

class HomeWorkRepository {
  final ApiService _apiService;

  HomeWorkRepository(this._apiService);

  Future<ApiResult<HomeWorkResponse>> getHomeWork(String studentId) async {
    try {
      final response = await _apiService.getHomeWorks(studentId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
