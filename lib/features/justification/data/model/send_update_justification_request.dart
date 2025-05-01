import 'package:json_annotation/json_annotation.dart';

part 'send_update_justification_request.g.dart';

@JsonSerializable()
class SendUpdateJustificationRequest {
  final String? parent;
  final String? content;
  final List<String>? attachments;

  SendUpdateJustificationRequest({
    this.parent,
    required this.content,
    this.attachments,
  });

  factory SendUpdateJustificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendUpdateJustificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendUpdateJustificationRequestToJson(this);
}
