import 'dart:developer';

import 'package:ecommerce_app_huma_volve/core/widgets/api/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/api/api_constants.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/model/sign_up_model.dart';

class ApiSignUp {
  final ApiClient apiClient;

  ApiSignUp({required this.apiClient});

  Future<SignUpModel> signUp(
    String name,
    String email,
    String password, {
    String avatar = "https://i.imgur.com/LDOO4Qs.jpg",
  }) async {
    final response = await apiClient.dio.post(
      ApiConstants.registerEndpoint,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "avatar": avatar,
      },
    );

    final Map<String, dynamic> jsondata = response.data;
    final modeldata = SignUpModel.fromJson(jsondata);
    log("SignUp name: ${modeldata.name}");
    log("SignUp email: ${modeldata.email}");
    return modeldata;
  }
}
