import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState<T> with _$NotificationsState<T> {
  const factory NotificationsState.initial() = _Initial;
  const factory NotificationsState.loading() = Loading;
  const factory NotificationsState.success(T data, {required bool hasMore}) =
      Success<T>;
  const factory NotificationsState.error(String error) = Error;
  const factory NotificationsState.loadingNotificationsCount() =
      LoadingNotificationsCount;
  const factory NotificationsState.successNotificationsCount(T data) =
      SuccessNotificationsCount<T>;
  const factory NotificationsState.errorNotificationsCount(String error) =
      ErrorNotificationsCount;
}
