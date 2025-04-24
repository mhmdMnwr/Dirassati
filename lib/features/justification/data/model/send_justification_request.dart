import 'package:json_annotation/json_annotation.dart';

part 'send_justification_request.g.dart';

@JsonSerializable()
class SendJustificationRequest {
  final String parent;
  final String absence;
  final String content;
  final List<String>? attachments;

  SendJustificationRequest({
    required this.parent,
    required this.absence,
    required this.content,
    this.attachments,
  });

  factory SendJustificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendJustificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendJustificationRequestToJson(this);
}
