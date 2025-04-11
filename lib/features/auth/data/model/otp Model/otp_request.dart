class OtpRequest {
  final String email;

  OtpRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory OtpRequest.fromJson(Map<String, dynamic> json) {
    return OtpRequest(
      email: json['email'],
    );
  }
}
