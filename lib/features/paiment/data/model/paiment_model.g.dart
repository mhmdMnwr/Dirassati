// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paiment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaimentResponse _$PaimentResponseFromJson(Map<String, dynamic> json) =>
    PaimentResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaimentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaimentResponseToJson(PaimentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

PaimentModel _$PaimentModelFromJson(Map<String, dynamic> json) => PaimentModel(
      id: json['id'] as String?,
      student: json['student'] == null
          ? null
          : PayStudent.fromJson(json['student'] as Map<String, dynamic>),
      amount: (json['amount'] as num?)?.toInt(),
      paymentMode: json['paymentMode'] as String?,
      paidAmount: (json['paidAmount'] as num?)?.toInt(),
      nextPaymentAmount: (json['nextPaymentAmount'] as num?)?.toInt(),
      nextPaymentDate: json['nextPaymentDate'] == null
          ? null
          : DateTime.parse(json['nextPaymentDate'] as String),
    );

Map<String, dynamic> _$PaimentModelToJson(PaimentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student': instance.student,
      'amount': instance.amount,
      'paymentMode': instance.paymentMode,
      'paidAmount': instance.paidAmount,
      'nextPaymentAmount': instance.nextPaymentAmount,
      'nextPaymentDate': instance.nextPaymentDate?.toIso8601String(),
    };

PayStudent _$PayStudentFromJson(Map<String, dynamic> json) => PayStudent(
      level: json['level'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$PayStudentToJson(PayStudent instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'level': instance.level,
      'lastName': instance.lastName,
    };
