// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_justification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendJustificationResponse _$SendJustificationResponseFromJson(
        Map<String, dynamic> json) =>
    SendJustificationResponse(
      statusCode: json['statusCode'] as String?,
      success: json['success'] as bool?,
      data: json['data'],
    );

Map<String, dynamic> _$SendJustificationResponseToJson(
        SendJustificationResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'success': instance.success,
      'data': instance.data,
    };
