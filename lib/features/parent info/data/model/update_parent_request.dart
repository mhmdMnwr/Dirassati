import 'package:json_annotation/json_annotation.dart';

part 'update_parent_request.g.dart';

@JsonSerializable()
class UpdateParentRequest {
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? phone;

  UpdateParentRequest({
    this.firstName,
    this.lastName,
    this.address,
    this.phone,
  });

  factory UpdateParentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateParentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateParentRequestToJson(this);
}
