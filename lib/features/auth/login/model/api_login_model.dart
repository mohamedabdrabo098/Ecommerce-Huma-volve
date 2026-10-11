class ApiLoginModel {
  final String accessToken;
  final String refreshToken;

  ApiLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ApiLoginModel.fromJson(Map<String, dynamic> json) {
    return ApiLoginModel(
      accessToken: json['access_token'] ?? json['access'] ?? '',
      refreshToken: json['refresh_token'] ?? json['refresh'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}

