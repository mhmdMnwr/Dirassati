import 'package:json_annotation/json_annotation.dart';

part 'years_model.g.dart';

@JsonSerializable()
class YearsResponse {
  final bool? success;
  final int? statusCode;
  final List<YearsModel>? data;

  YearsResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory YearsResponse.fromJson(Map<String, dynamic> json) =>
      _$YearsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YearsResponseToJson(this);
}

@JsonSerializable()
class YearsModel {
  final String? year;
  final int? trimestre;

  YearsModel({
    this.year,
    this.trimestre,
  });

  factory YearsModel.fromJson(Map<String, dynamic> json) =>
      _$YearsModelFromJson(json);

  Map<String, dynamic> toJson() => _$YearsModelToJson(this);
}
