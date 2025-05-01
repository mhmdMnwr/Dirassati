import 'package:json_annotation/json_annotation.dart';

part 'absence_response.g.dart';

@JsonSerializable()
class AbsenceResponse {
  final bool success;
  final int statusCode;
  final AbsenceData? data;

  const AbsenceResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory AbsenceResponse.fromJson(Map<String, dynamic> json) =>
      _$AbsenceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AbsenceResponseToJson(this);
}

@JsonSerializable()
class AbsenceData {
  final bool? hasJustificationPending;
  @JsonKey(name: '_id')
  final String? id;
  final String? subjectName;
  final bool? isJustified;
  final DateTime? absentSince;
  final Justification? justification;

  const AbsenceData({
    this.hasJustificationPending,
    this.id,
    this.subjectName,
    this.isJustified,
    this.absentSince,
    this.justification,
  });

  factory AbsenceData.fromJson(Map<String, dynamic> json) =>
      _$AbsenceDataFromJson(json);
  Map<String, dynamic> toJson() => _$AbsenceDataToJson(this);
}

@JsonSerializable()
class Justification {
  final String? id;
  final String? content;
  final List<String>? attachments;

  const Justification({
    this.id,
    this.content,
    this.attachments,
  });

  factory Justification.fromJson(Map<String, dynamic> json) =>
      _$JustificationFromJson(json);
  Map<String, dynamic> toJson() => _$JustificationToJson(this);
}
