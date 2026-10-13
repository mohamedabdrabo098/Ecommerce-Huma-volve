import '../../../../core/dummy_data.dart';

abstract class HomeRepository {
  Future<List<String>> getCategories();
  Future<List<Product>> getProducts();
}

