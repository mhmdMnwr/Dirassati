import 'package:dirasati/features/notifications/data/model/notifications_model.dart';
import 'package:dirasati/features/notifications/data/repo/notifications_repo.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repository;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasReachedMax = false;
  // Change the list type to hold NotificationModel
  List<NotificationModel> notifications = [];

  NotificationsCubit(
    this._repository,
  ) : super(const NotificationsState.initial());

  void getNotifications() async {
    // Prevent concurrent fetches and fetching beyond the max
    if (_isLoading || _hasReachedMax) return;

    _isLoading = true;
    // Emit loading state only if it's the first page fetch
    if (_currentPage == 1) {
      emit(const NotificationsState.loading());
    } // For subsequent pages, the UI will show a loading indicator at the bottom

    final response = await _repository.getMyNotifications(page: _currentPage);

    response.when(success: (notificationsResponse) {
      final newNotifications = notificationsResponse.data ?? [];
      if (newNotifications.isEmpty) {
        _hasReachedMax = true;
      } else {
        // Add the new NotificationModel items to the existing list
        notifications.addAll(newNotifications);
        _currentPage++;
      }
      // Emit success with the updated flat list and hasMore flag
      emit(NotificationsState.success(
          List<NotificationModel>.from(notifications),
          hasMore: !_hasReachedMax));
    }, failure: (error) {
      // Keep existing data on error, just emit error state
      emit(NotificationsState.error(
          error.apiErrorModel.message ?? 'Unknown error'));
    });

    _isLoading = false; // Reset loading flag
  }

  // Optional: Add a method to reset and fetch from the beginning (e.g., for pull-to-refresh)
  void refreshNotifications() {
    _currentPage = 1;
    _hasReachedMax = false;
    notifications = [];
    // Potentially clear the state before fetching again if needed
    // emit(const NotificationsState.initial());
    getNotifications();
  }
}
