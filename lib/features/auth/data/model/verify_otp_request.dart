class VerifyOtpRequest {
  final String otp;
  final String email;

  VerifyOtpRequest({required this.otp, required this.email});

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequest(
      otp: json['otp'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'email': email,
    };
  }
}
