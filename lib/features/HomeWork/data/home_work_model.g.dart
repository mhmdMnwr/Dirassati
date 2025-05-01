// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_work_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeWorkModel _$HomeWorkModelFromJson(Map<String, dynamic> json) =>
    HomeWorkModel(
      success: json['success'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeWorkData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeWorkModelToJson(HomeWorkModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

HomeWorkData _$HomeWorkDataFromJson(Map<String, dynamic> json) => HomeWorkData(
      id: json['_id'] as String,
      subjectName: json['subjectName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      deadLine: DateTime.parse(json['deadLine'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$HomeWorkDataToJson(HomeWorkData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'subjectName': instance.subjectName,
      'title': instance.title,
      'description': instance.description,
      'attachments': instance.attachments,
      'deadLine': instance.deadLine.toIso8601String(),
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
