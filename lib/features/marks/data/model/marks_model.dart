import 'package:json_annotation/json_annotation.dart';

part 'marks_model.g.dart';

@JsonSerializable()
class GetMarksResponse {
  final bool? success;
  final int? statusCode;
  final int? level;
  final List<MarksModel>? data;

  GetMarksResponse({
    this.success,
    this.statusCode,
    this.data,
    this.level,
  });

  int get isMainCofficientTotal {
    if (data == null || data!.isEmpty) {
      return 0;
    }
    int total = 0;
    for (var mark in data!) {
      if (mark.subject!.isMain) {
        total += mark.subject!.coefficient;
      }
    }
    return total;
  }

  int get coefficientTotal {
    if (data == null || data!.isEmpty) {
      return 0;
    }
    int total = 0;
    for (var mark in data!) {
      total += mark.subject!.coefficient;
    }
    return total;
  }

  double get totalAvg {
    if (data == null || data!.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var mark in data!) {
      total += (mark.calculateSubjectaverage * mark.subject!.coefficient);
    }
    return total / coefficientTotal;
  }

  double get isMainAvg {
    if (data == null || data!.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var mark in data!) {
      if (mark.subject!.isMain) {
        total += (mark.calculateSubjectaverage * mark.subject!.coefficient);
      }
    }
    return total / isMainCofficientTotal;
  }

  int get totalAbsence {
    if (data == null || data!.isEmpty) {
      return 0;
    }
    int total = 0;
    for (var mark in data!) {
      total += mark.nbOfAbsences!;
    }
    return total;
  }

  factory GetMarksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMarksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMarksResponseToJson(this);
}

@JsonSerializable()
class MarksModel {
  final Subject? subject;
  final int? nbOfAbsences;
  final int? noteCC;
  final int? firstTest;
  final int? secondTest;
  final int? exam;
  final String? id;

  MarksModel({
    this.subject,
    this.nbOfAbsences,
    this.noteCC,
    this.firstTest,
    this.secondTest,
    this.exam,
    this.id,
  });

  double get calculateSubjectaverage {
    double avg = 0;
    if (subject!.isMain) {
      avg = ((noteCC ?? 0) +
              (firstTest ?? 0) +
              (secondTest ?? 0) +
              2 * (exam ?? 0)) /
          5;
      return avg;
    } else {
      avg = ((noteCC ?? 0) + (firstTest ?? 0) + 2 * (exam ?? 0)) / 4;
      return avg;
    }
  }

  factory MarksModel.fromJson(Map<String, dynamic> json) =>
      _$MarksModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarksModelToJson(this);
}

@JsonSerializable()
class Subject {
  final String name;
  final int coefficient;
  final bool isMain;
  final String id;

  Subject({
    required this.name,
    required this.coefficient,
    required this.isMain,
    required this.id,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
