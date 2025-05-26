import 'package:freezed_annotation/freezed_annotation.dart';

class StudentsResponse {
  final bool success;
  final int statusCode;
  final List<Student> data;

  const StudentsResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory StudentsResponse.fromJson(Map<String, dynamic> json) {
    return StudentsResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      data: (json['data'] as List).map((e) => Student.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  @JsonKey(name: 'class')
  final Classa? classa;
  final String code;
  final String level;
  final DateTime birthDate;
  final DateTime inscriptionDate;
  final String gender;
  final String phone;
  final String address;
  final bool isAbsent;

  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.classa,
    required this.code,
    required this.level,
    required this.birthDate,
    required this.inscriptionDate,
    required this.gender,
    required this.phone,
    required this.address,
    required this.isAbsent,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      classa: Classa.fromJson(json['class'] as Map<String, dynamic>),
      code: json['code'],
      level: json['level'],
      birthDate: DateTime.parse(json['birthDate']),
      inscriptionDate: DateTime.parse(json['inscriptionDate']),
      gender: json['gender'],
      phone: json['phone'],
      address: json['address'],
      isAbsent: json['isAbsent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'class': classa?.toJson(),
      'code': code,
      'level': level,
      'birthDate': birthDate.toIso8601String(),
      'inscriptionDate': inscriptionDate.toIso8601String(),
      'gender': gender,
      'phone': phone,
      'address': address,
      'isAbsent': isAbsent,
    };
  }
}

class Classa {
  final String? planning;
  final String? examPlanning;

  const Classa({
    this.planning,
    this.examPlanning,
  });

  factory Classa.fromJson(Map<String, dynamic> json) {
    return Classa(
      planning: json['planning'],
      examPlanning: json['examPlanning'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planning': planning,
      'examPlanning': examPlanning,
    };
  }
}
