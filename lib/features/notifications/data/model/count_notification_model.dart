import 'package:json_annotation/json_annotation.dart';

part 'count_notification_model.g.dart';

@JsonSerializable()
class CountNotificationModel {
  final int? data;

  CountNotificationModel({required this.data});

  factory CountNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$CountNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountNotificationModelToJson(this);
}
