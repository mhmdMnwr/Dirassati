// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMeResponse _$GetMeResponseFromJson(Map<String, dynamic> json) =>
    GetMeResponse(
      sucess: json['sucess'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      data: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMeResponseToJson(GetMeResponse instance) =>
    <String, dynamic>{
      'sucess': instance.sucess,
      'statusCode': instance.statusCode,
      'data': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'phone': instance.phone,
      'address': instance.address,
      'gender': instance.gender,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
