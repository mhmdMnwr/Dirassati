import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/auth/data/model/login%20Model/login_response.dart';
import 'package:dirasati/features/change%20password/data/model/change_password_request.dart';

class ChangePasswordRepo {
  final ApiService apiService;
  ChangePasswordRepo(this.apiService);

  Future<ApiResult<LoginResponse>> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    try {
      final response = await apiService.changePassword(changePasswordRequest);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
