import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/features/notifications/data/model/notifications_model.dart';
import 'package:dirasati/features/notifications/data/repo/notifications_repo.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repository;
  final int _limit = 8;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasReachedMax = false;
  List<NotificationModel> notifications = [];

  NotificationsCubit(this._repository)
      : super(const NotificationsState.initial());

  void getNotifications() async {
    // Don’t fetch if already loading or no more pages
    if (_isLoading || _hasReachedMax) return;

    _isLoading = true;
    if (_currentPage == 1) {
      emit(const NotificationsState.loading());
    }

    final response = await _repository.getMyNotifications(
      page: _currentPage,
    );

    response.when(
      success: (notificationsResponse) {
        final newNotifications = notificationsResponse.data ?? [];

        // If we got fewer than _limit items, there *are* no more pages
        if (newNotifications.length < _limit) {
          _hasReachedMax = true;
        } else {
          _currentPage++;
        }

        // Append whatever we got (even if < _limit)
        notifications.addAll(newNotifications);

        emit(NotificationsState.success(
          List<NotificationModel>.from(notifications),
          hasMore: !_hasReachedMax,
        ));
      },
      failure: (error) {
        emit(NotificationsState.error(
          error.apiErrorModel.message ?? 'Unknown error',
        ));
      },
    );

    _isLoading = false;
  }

  // Optional: Add a method to reset and fetch from the beginning (e.g., for pull-to-refresh)
  // void refreshNotifications() {
  //   _currentPage = 1;
  //   _hasReachedMax = false;
  //   notifications = [];
  //   // Potentially clear the state before fetching again if needed
  //   // emit(const NotificationsState.initial());
  //   getNotifications();
  // }

  // Optional: Add a method to fetch the count of notifications
  void getCountNotifications() async {
    String receiverId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId);
    final response = await _repository.getCountNotifications(receiverId);
    response.when(success: (countResponse) {
      emit(NotificationsState.successNotificationsCount(
          countResponse.data ?? 0));
    }, failure: (error) {
      emit(NotificationsState.error(
          error.apiErrorModel.message ?? 'Unknown error'));
    });
  }
}
