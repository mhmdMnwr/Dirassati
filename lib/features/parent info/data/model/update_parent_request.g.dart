// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_parent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateParentRequest _$UpdateParentRequestFromJson(Map<String, dynamic> json) =>
    UpdateParentRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UpdateParentRequestToJson(
        UpdateParentRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'phone': instance.phone,
    };
