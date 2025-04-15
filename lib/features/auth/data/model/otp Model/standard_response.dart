class StandardResponse {
  final String status;
  final String message;

  StandardResponse({
    required this.status,
    required this.message,
  });

  factory StandardResponse.fromJson(Map<String, dynamic> json) {
    return StandardResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
