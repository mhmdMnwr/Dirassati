// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_justification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendJustificationRequest _$SendJustificationRequestFromJson(
        Map<String, dynamic> json) =>
    SendJustificationRequest(
      parent: json['parent'] as String,
      absence: json['absence'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$SendJustificationRequestToJson(
        SendJustificationRequest instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'absence': instance.absence,
      'content': instance.content,
    };
