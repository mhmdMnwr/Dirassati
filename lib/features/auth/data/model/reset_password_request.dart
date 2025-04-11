class ResetPasswordRequest {
  final String email;
  final String newPassword;

  ResetPasswordRequest({required this.newPassword, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
    };
  }

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequest(
      email: json['email'],
      newPassword: json['newPassword'],
    );
  }
}
