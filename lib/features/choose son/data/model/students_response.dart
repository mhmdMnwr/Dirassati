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
  final String classId;
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
    required this.classId,
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
      classId: json['class'],
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
      'class': classId,
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
