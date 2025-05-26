import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/paiment/data/model/paiment_model.dart';

class PaimentRepo {
  ApiService _apiService;

  PaimentRepo(this._apiService);

  Future<ApiResult<PaimentResponse>> getPaiment() async {
    try {
      final response = await _apiService.getMyTuition();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
