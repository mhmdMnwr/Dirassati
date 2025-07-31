// import 'package:dirasati/core/helpers/constants.dart';
// import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/features/notifications/data/model/notifications_model.dart';
import 'package:dirasati/features/notifications/data/repo/notifications_repo.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  // ignore: unused_field
  final NotificationsRepository _repository;
  final int _limit = 8;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasReachedMax = false;
  List<NotificationModel> notifications = [];

  NotificationsCubit(this._repository)
      : super(const NotificationsState.initial());

  void getNotifications() async {
    // Don't fetch if already loading or no more pages
    if (_isLoading || _hasReachedMax) return;

    _isLoading = true;
    if (_currentPage == 1) {
      emit(const NotificationsState.loading());
    }

    // Add delay to simulate network request
    await Future.delayed(const Duration(seconds: 1));

    // Create dummy notifications
    final dummyNotifications = [
      NotificationModel(
        id: 'notif_1',
        type: 'ABSENCE_CREATED',
        status: 'unread',
        title: 'إشعار غياب', // Absence notification
        description: 'طالبك سارة أحمد غائب اليوم. يرجى تبرير الغياب.',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: 'notif_2',
        type: 'MARKS_UPDATED',
        status: 'unread',
        title: 'تحديث الدرجات', // Marks updated
        description: 'تم تحديث درجات الرياضيات لطالبك محمد علي.',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      NotificationModel(
        id: 'notif_3',
        type: 'JUSTIFICATION_ACCEPTED',
        status: 'read',
        title: 'قبول التبرير', // Justification accepted
        description: 'تم قبول تبرير الغياب لطالبك فاطمة حسن.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationModel(
        id: 'notif_4',
        type: 'HOMEWORK_ASSIGNED',
        status: 'read',
        title: 'واجب جديد', // New homework
        description: 'تم إضافة واجب جديد في مادة العلوم.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NotificationModel(
        id: 'notif_5',
        type: 'PAYMENT_REMINDER',
        status: 'unread',
        title: 'تذكير بالدفع', // Payment reminder
        description: 'موعد استحقاق الرسوم الدراسية قريب.',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    // Simulate pagination
    final startIndex = (_currentPage - 1) * _limit;
    final newNotifications = dummyNotifications.skip(startIndex).take(_limit).toList();

    // If we got fewer than _limit items, there are no more pages
    if (newNotifications.length < _limit) {
      _hasReachedMax = true;
    } else {
      _currentPage++;
    }

    // Append whatever we got
    notifications.addAll(newNotifications);

    emit(NotificationsState.success(
      List<NotificationModel>.from(notifications),
      hasMore: !_hasReachedMax,
    ));

    _isLoading = false;

    // Comment out the original API call
    /*
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
        emit(NotificationsState.error(error.apiErrorModel.message ?? ''));
      },
    );
    */
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
    // Add delay to simulate network request
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return dummy count - 3 unread notifications
    emit(const NotificationsState.successNotificationsCount(3));
    
    // Comment out the original API call
    /*
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
    */
  }
}
