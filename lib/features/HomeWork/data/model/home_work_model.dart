import 'package:json_annotation/json_annotation.dart';

part 'home_work_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeWorkResponse {
  final bool success;
  final int statusCode;
  final List<HomeWorkModel>? data;

  HomeWorkResponse({
    required this.success,
    required this.statusCode,
    this.data,
  });

  factory HomeWorkResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HomeWorkModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? subjectName;
  final String? title;
  final String? description;
  final List<String>? attachments;
  final DateTime? deadLine;
  final String? status;
  final DateTime? createdAt;

  HomeWorkModel({
    required this.id,
    required this.subjectName,
    required this.title,
    required this.description,
    required this.attachments,
    required this.deadLine,
    required this.status,
    required this.createdAt,
  });

  factory HomeWorkModel.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkModelToJson(this);
}
