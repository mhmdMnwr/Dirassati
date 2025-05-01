import 'package:json_annotation/json_annotation.dart';

part 'home_work_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeWorkModel {
  final bool success;
  final int statusCode;
  final List<HomeWorkData> data;

  HomeWorkModel({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory HomeWorkModel.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HomeWorkData {
  @JsonKey(name: '_id')
  final String id;
  final String subjectName;
  final String title;
  final String description;
  final List<String> attachments;
  final DateTime deadLine;
  final String status;
  final DateTime createdAt;

  HomeWorkData({
    required this.id,
    required this.subjectName,
    required this.title,
    required this.description,
    required this.attachments,
    required this.deadLine,
    required this.status,
    required this.createdAt,
  });

  factory HomeWorkData.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkDataFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkDataToJson(this);
}
