import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/features/notifications/data/model/count_notification_model.dart';
import 'package:dirasati/features/notifications/data/model/notifications_model.dart';

class NotificationsRepository {
  final ApiService _apiService;

  NotificationsRepository(this._apiService);

  Future<ApiResult<NotificationsResponse>> getMyNotifications(
      {int limit = 8, required int page}) async {
    try {
      final response = await _apiService.getMyNotifications(page, limit);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CountNotificationModel>> getCountNotifications(
      String receiverId) async {
    try {
      final response = await _apiService.getNotificationsCount(receiverId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
