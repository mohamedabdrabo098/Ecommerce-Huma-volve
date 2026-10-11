import 'dart:developer';

import 'package:ecommerce_app_huma_volve/core/widgets/api/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/api/api_constants.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/model/api_login_model.dart';

class ApiLogin {
  final ApiClient apiClient;

  ApiLogin({required this.apiClient});

  Future<ApiLoginModel> logIn(String email, String password) async {
    final response = await apiClient.dio.post(
      ApiConstants.loginEndpoint,
      data: {"email": email, "password": password},
    );

    final Map<String, dynamic> jsondata = response.data;
    final modeldata = ApiLoginModel.fromJson(jsondata);
    log("token:${modeldata.accessToken}");
    log("reftoken:${modeldata.refreshToken}");
    return modeldata;
  }
}
