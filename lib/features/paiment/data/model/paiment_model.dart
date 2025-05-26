// import 'package:json_annotation/json_annotation.dart';

// part 'paiment_model.g.dart';

// @JsonSerializable(explicitToJson: true)
// class PaimentModel {
//   final bool success;
//   final List<PaimentData> data;

//   PaimentModel({
//     required this.success,
//     required this.data,
//   });

//   factory PaimentModel.fromJson(Map<String, dynamic> json) =>
//       _$PaimentModelFromJson(json);

//   Map<String, dynamic> toJson() => _$PaimentModelToJson(this);
// }

// @JsonSerializable(explicitToJson: true)
// class PaimentData {
//   final double amount;
//   final double restamount;
//   final MyStudent mystudent;

//   PaimentData({
//     required this.amount,
//     required this.restamount,
//     required this.mystudent,
//   });

//   factory PaimentData.fromJson(Map<String, dynamic> json) =>
//       _$PaimentDataFromJson(json);

//   Map<String, dynamic> toJson() => _$PaimentDataToJson(this);
// }

// @JsonSerializable()
// class MyStudent {
//   final String name;
//   final String lastname;
//   final String level;

//   MyStudent({
//     required this.name,
//     required this.lastname,
//     required this.level,
//   });

//   factory MyStudent.fromJson(Map<String, dynamic> json) =>
//       _$MyStudentFromJson(json);

//   Map<String, dynamic> toJson() => _$MyStudentToJson(this);
// }
