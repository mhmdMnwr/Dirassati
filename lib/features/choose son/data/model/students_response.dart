import 'package:freezed_annotation/freezed_annotation.dart';

part 'students_response.g.dart';

@JsonSerializable()
class StudentsResponse {
  final bool success;
  final int statusCode;
  final List<Student> data;

  const StudentsResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory StudentsResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsResponseToJson(this);
}

@JsonSerializable()
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

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

@JsonSerializable()
class Classa {
  final String? planning;
  final String? examPlanning;

  const Classa({
    this.planning,
    this.examPlanning,
  });

  factory Classa.fromJson(Map<String, dynamic> json) => _$ClassaFromJson(json);
  Map<String, dynamic> toJson() => _$ClassaToJson(this);
}
