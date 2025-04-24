import 'package:json_annotation/json_annotation.dart';

part 'get_me_response.g.dart';

@JsonSerializable()
class GetMeResponse {
  final bool success;
  final int statusCode;
  final UserData data;

  GetMeResponse({
    required this.success,
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
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? role;
  final String? phone;
  final String? address;
  final String? gender;
  final String? createdAt;
  final String? updatedAt;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.phone,
    this.address,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserData copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? phone,
    String? address,
    String? gender,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserData(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
