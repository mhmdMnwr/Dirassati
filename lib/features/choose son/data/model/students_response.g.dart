// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsResponse _$StudentsResponseFromJson(Map<String, dynamic> json) =>
    StudentsResponse(
      success: json['success'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentsResponseToJson(StudentsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'data': instance.data,
    };

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      classa: json['class'] == null
          ? null
          : Classa.fromJson(json['class'] as Map<String, dynamic>),
      code: json['code'] as String,
      level: json['level'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      inscriptionDate: DateTime.parse(json['inscriptionDate'] as String),
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      isAbsent: json['isAbsent'] as bool,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'class': instance.classa,
      'code': instance.code,
      'level': instance.level,
      'birthDate': instance.birthDate.toIso8601String(),
      'inscriptionDate': instance.inscriptionDate.toIso8601String(),
      'gender': instance.gender,
      'phone': instance.phone,
      'address': instance.address,
      'isAbsent': instance.isAbsent,
    };

Classa _$ClassaFromJson(Map<String, dynamic> json) => Classa(
      planning: json['planning'] as String?,
      examPlanning: json['examPlanning'] as String?,
    );

Map<String, dynamic> _$ClassaToJson(Classa instance) => <String, dynamic>{
      'planning': instance.planning,
      'examPlanning': instance.examPlanning,
    };
