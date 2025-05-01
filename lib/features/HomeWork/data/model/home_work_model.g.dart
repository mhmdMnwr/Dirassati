// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_work_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeWorkResponse _$HomeWorkResponseFromJson(Map<String, dynamic> json) =>
    HomeWorkResponse(
      success: json['success'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HomeWorkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeWorkResponseToJson(HomeWorkResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

HomeWorkModel _$HomeWorkModelFromJson(Map<String, dynamic> json) =>
    HomeWorkModel(
      id: json['_id'] as String?,
      subjectName: json['subjectName'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deadLine: json['deadLine'] == null
          ? null
          : DateTime.parse(json['deadLine'] as String),
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$HomeWorkModelToJson(HomeWorkModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'subjectName': instance.subjectName,
      'title': instance.title,
      'description': instance.description,
      'attachments': instance.attachments,
      'deadLine': instance.deadLine?.toIso8601String(),
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
