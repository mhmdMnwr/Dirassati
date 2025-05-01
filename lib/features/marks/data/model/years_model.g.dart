// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'years_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearsResponse _$YearsResponseFromJson(Map<String, dynamic> json) =>
    YearsResponse(
      success: json['success'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => YearsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YearsResponseToJson(YearsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'data': instance.data,
    };

YearsModel _$YearsModelFromJson(Map<String, dynamic> json) => YearsModel(
      year: json['year'] as String?,
      trimestre: (json['trimestre'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YearsModelToJson(YearsModel instance) =>
    <String, dynamic>{
      'year': instance.year,
      'trimestre': instance.trimestre,
    };
