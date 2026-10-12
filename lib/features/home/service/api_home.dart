import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/api/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/api/api_constants.dart';

class ApiHome {
  final ApiClient apiClient;

  ApiHome({required this.apiClient});

  Future<List<String>> getCategories() async {
    final response = await apiClient.dio.get(ApiConstants.categoriesEndpoint);
    final List data = response.data;
    final categoryNames = data
        .map((item) => item['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    return ['All', ...categoryNames];
  }

  Future<List<Product>> getProducts() async {
    final response = await apiClient.dio.get(ApiConstants.productsEndpoint);
    final List data = response.data;
    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

