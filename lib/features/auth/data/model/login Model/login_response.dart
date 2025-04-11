class LoginResponse {
  late final Tokens tokens;
  late final String message;
  late final int statusCode;
  LoginResponse({
    required this.tokens,
    required this.message,
    required this.statusCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      tokens: Tokens.fromJson(json['tokens']),
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokens': tokens.toJson(),
      'message': message,
      'statusCode': statusCode,
    };
  }
}

class Tokens {
  late final String accessToken;
  late final String refreshToken;
  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
