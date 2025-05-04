import 'package:dirasati/core/theming/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Widget get getNotificationIcon {
    Widget icon(String justificationIcon) {
      return Image.asset(
        justificationIcon,
        width: 50.w,
        height: 50.h,
      );
    }

    switch (type) {
      case 'ABSENCE_CREATED':
        return icon(IconsManager.absent);
      case 'JUSTIFICATION_ACCEPTED':
        return icon(IconsManager.absence);
      case 'JUSTIFICATION_REJECTED':
        return icon(IconsManager.absent);
      case 'HOMEWORK_CREATED':
        return icon(IconsManager.homeWork);
      case 'PLANNING_UPDATED':
        return icon(IconsManager.schedule);
      case 'GRADES_UPDATED':
        return icon(IconsManager.marksUpdated);
      case 'REMARK':
        return icon(IconsManager.notifications);
      default:
        return icon(IconsManager.notifications);
    }
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
