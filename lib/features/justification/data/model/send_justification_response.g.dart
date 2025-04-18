// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_justification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendJustificationResponse _$SendJustificationResponseFromJson(
        Map<String, dynamic> json) =>
    SendJustificationResponse(
      statusCode: json['statusCode'] as String,
      sucess: json['sucess'] as bool,
    );

Map<String, dynamic> _$SendJustificationResponseToJson(
        SendJustificationResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'sucess': instance.sucess,
    };
