// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenceResponse _$AbsenceResponseFromJson(Map<String, dynamic> json) =>
    AbsenceResponse(
      success: json['success'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      data: json['data'] == null
          ? null
          : AbsenceData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AbsenceResponseToJson(AbsenceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'data': instance.data,
    };

AbsenceData _$AbsenceDataFromJson(Map<String, dynamic> json) => AbsenceData(
      hasJustificationPending: json['hasJustificationPending'] as bool?,
      id: json['_id'] as String?,
      subjectName: json['subjectName'] as String?,
      isJustified: json['isJustified'] as bool?,
      absentSince: json['absentSince'] == null
          ? null
          : DateTime.parse(json['absentSince'] as String),
      justification: json['justification'] == null
          ? null
          : Justification.fromJson(
              json['justification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AbsenceDataToJson(AbsenceData instance) =>
    <String, dynamic>{
      'hasJustificationPending': instance.hasJustificationPending,
      '_id': instance.id,
      'subjectName': instance.subjectName,
      'isJustified': instance.isJustified,
      'absentSince': instance.absentSince?.toIso8601String(),
      'justification': instance.justification,
    };

Justification _$JustificationFromJson(Map<String, dynamic> json) =>
    Justification(
      id: json['id'] as String?,
      content: json['content'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$JustificationToJson(Justification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'attachments': instance.attachments,
    };
