import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/api/api_constants.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  }
}