import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/notifications/data/model/notifications_model.dart';

class NotificationsRepository {
  final ApiService _apiService;

  NotificationsRepository(this._apiService);

  Future<ApiResult<NotificationsResponse>> getMyNotifications(
      {int limit = 15, required int page}) async {
    try {
      final response = await _apiService.getMyNotifications(page, limit);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
