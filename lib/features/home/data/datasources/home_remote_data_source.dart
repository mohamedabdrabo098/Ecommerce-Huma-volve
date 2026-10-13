import '../../../../core/dummy_data.dart';
import '../../../../core/widgets/api/api_client.dart';
import '../../../../core/widgets/api/api_constants.dart';

abstract class HomeRemoteDataSource {
  Future<List<String>> getCategories();
  Future<List<Product>> getProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<String>> getCategories() async {
    final response = await apiClient.dio.get(ApiConstants.categoriesEndpoint);
    final List data = response.data;
    final categoryNames = data
        .map((item) => item['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    return ['All', ...categoryNames];
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await apiClient.dio.get(ApiConstants.productsEndpoint);
    final List data = response.data;
    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

