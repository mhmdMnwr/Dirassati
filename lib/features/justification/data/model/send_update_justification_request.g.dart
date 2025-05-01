// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_update_justification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendUpdateJustificationRequest _$SendUpdateJustificationRequestFromJson(
        Map<String, dynamic> json) =>
    SendUpdateJustificationRequest(
      parent: json['parent'] as String?,
      content: json['content'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SendUpdateJustificationRequestToJson(
        SendUpdateJustificationRequest instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'content': instance.content,
      'attachments': instance.attachments,
    };
