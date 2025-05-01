// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMarksResponse _$GetMarksResponseFromJson(Map<String, dynamic> json) =>
    GetMarksResponse(
      success: json['success'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MarksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: (json['level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetMarksResponseToJson(GetMarksResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'level': instance.level,
      'data': instance.data,
    };

MarksModel _$MarksModelFromJson(Map<String, dynamic> json) => MarksModel(
      subject: json['subject'] == null
          ? null
          : Subject.fromJson(json['subject'] as Map<String, dynamic>),
      nbOfAbsences: (json['nbOfAbsences'] as num?)?.toInt(),
      noteCC: (json['noteCC'] as num?)?.toInt(),
      firstTest: (json['firstTest'] as num?)?.toInt(),
      secondTest: (json['secondTest'] as num?)?.toInt(),
      exam: (json['exam'] as num?)?.toInt(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$MarksModelToJson(MarksModel instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'nbOfAbsences': instance.nbOfAbsences,
      'noteCC': instance.noteCC,
      'firstTest': instance.firstTest,
      'secondTest': instance.secondTest,
      'exam': instance.exam,
      'id': instance.id,
    };

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      name: json['name'] as String,
      coefficient: (json['coefficient'] as num).toInt(),
      isMain: json['isMain'] as bool,
      id: json['id'] as String,
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'name': instance.name,
      'coefficient': instance.coefficient,
      'isMain': instance.isMain,
      'id': instance.id,
    };
