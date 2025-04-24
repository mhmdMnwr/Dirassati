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

  const AbsenceData({
    this.hasJustificationPending,
    this.id,
    this.subjectName,
    this.isJustified,
    this.absentSince,
  });

  factory AbsenceData.fromJson(Map<String, dynamic> json) =>
      _$AbsenceDataFromJson(json);
  Map<String, dynamic> toJson() => _$AbsenceDataToJson(this);
}
