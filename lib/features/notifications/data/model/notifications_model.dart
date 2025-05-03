import 'package:dirasati/core/theming/icons.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';

@JsonSerializable()
class NotificationsResponse {
  final bool success;
  final int statusCode;
  final List<NotificationModel>? data;

  NotificationsResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? type;
  final String? status;
  final String? title;
  final String? description;
  final DateTime? createdAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.status,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  String get getNotifictionIcon {
    return IconsManager.absence;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
