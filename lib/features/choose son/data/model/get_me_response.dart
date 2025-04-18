import 'package:json_annotation/json_annotation.dart';

part 'get_me_response.g.dart';

@JsonSerializable()
class GetMeResponse {
  final bool sucess;
  final int statusCode;
  final UserData data;

  GetMeResponse({
    required this.sucess,
    required this.statusCode,
    required this.data,
  });

  factory GetMeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMeResponseToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String phone;
  final String address;
  final String gender;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.phone,
    required this.address,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
