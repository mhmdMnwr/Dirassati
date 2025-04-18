// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenceResponse _$AbsenceResponseFromJson(Map<String, dynamic> json) =>
    AbsenceResponse(
      success: json['sucess'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => AbsenceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AbsenceResponseToJson(AbsenceResponse instance) =>
    <String, dynamic>{
      'sucess': instance.success,
      'statusCode': instance.statusCode,
      'data': instance.data,
    };

AbsenceData _$AbsenceDataFromJson(Map<String, dynamic> json) => AbsenceData(
      id: json['_id'] as String,
      subjectName: json['subjectName'] as String,
      isJustified: json['isJustified'] as bool,
      absentSince: DateTime.parse(json['absentSince'] as String),
      nbOfAbsences: (json['nbOfAbsences'] as num).toInt(),
    );

Map<String, dynamic> _$AbsenceDataToJson(AbsenceData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'subjectName': instance.subjectName,
      'isJustified': instance.isJustified,
      'absentSince': instance.absentSince.toIso8601String(),
      'nbOfAbsences': instance.nbOfAbsences,
    };
