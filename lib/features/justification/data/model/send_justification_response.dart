import 'package:json_annotation/json_annotation.dart';
part 'send_justification_response.g.dart';

@JsonSerializable()
class SendJustificationResponse {
  final String? statusCode;
  final bool? success;
  final dynamic data;

  SendJustificationResponse({this.statusCode, this.success, this.data});

  factory SendJustificationResponse.fromJson(Map<String, dynamic> json) =>
      _$SendJustificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendJustificationResponseToJson(this);
}
