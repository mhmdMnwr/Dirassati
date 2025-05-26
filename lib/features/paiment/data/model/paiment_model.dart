import 'package:json_annotation/json_annotation.dart';

part 'paiment_model.g.dart';

@JsonSerializable()
class PaimentResponse {
  final bool? success;
  final List<PaimentModel>? data;

  PaimentResponse({
    this.success,
    this.data,
  });

  get NextPaimnetDate {
    if (data != null && data!.isNotEmpty) {
      return data!
          .map((e) => e.nextPaymentDate)
          .where((d) => d != null) // Filter out null dates
          .reduce((a, b) => a!.isBefore(b!) ? a : b); // Add null checks
    }
    return null;
  }

  get nextPaimentAmount {
    if (data != null && data!.isNotEmpty) {
      final nextDate = NextPaimnetDate;
      if (nextDate != null) {
        final paiment = data!.firstWhere(
          (e) => e.nextPaymentDate == nextDate,
          orElse: () => data!.first,
        );
        return paiment.nextPaymentAmount;
      }
    }
    return null;
  }

  get totalNotPaidAmount {
    if (data != null && data!.isNotEmpty) {
      return data!
          .map((e) => (e.amount ?? 0) - (e.paidAmount ?? 0)) // Provide defaults for null values
          .fold(0, (prev, element) => prev + element);
    }
    return 0;
  }

  get daysLeftForNextPaiment {
    final nextDate = NextPaimnetDate;
    if (nextDate != null) {
      final now = DateTime.now();
      return nextDate.difference(now).inDays;
    }
    return null;
  }

  factory PaimentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaimentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaimentResponseToJson(this);
}

@JsonSerializable()
class PaimentModel {
  final String? id;
  final PayStudent? student;
  final int? amount;
  final String? paymentMode;
  final int? paidAmount;
  final int? nextPaymentAmount;
  final DateTime? nextPaymentDate;

  PaimentModel({
    this.id,
    this.student,
    this.amount,
    this.paymentMode,
    this.paidAmount,
    this.nextPaymentAmount,
    this.nextPaymentDate,
  });

  factory PaimentModel.fromJson(Map<String, dynamic> json) =>
      _$PaimentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaimentModelToJson(this);
}

@JsonSerializable()
class PayStudent {
  final String? firstName;
  final String? level;
  final String? lastName;

  PayStudent({
    this.level,
    this.firstName,
    this.lastName,
  });

  factory PayStudent.fromJson(Map<String, dynamic> json) =>
      _$PayStudentFromJson(json);
  Map<String, dynamic> toJson() => _$PayStudentToJson(this);
}

// "_id": "68349eed0b4a89cdcb86c5d1",
//             "student": "68349eed0b4a89cdcb86c5cc",
//             "amount": 30000,
//             "paidAmount": 0,
//             "paymentMode": "quarterly",
//             "nextPaymentAmount": 7500,
//             "__v": 0,
//             "nextPaymentDate": "2025-08-26T17:03:41.837Z"
