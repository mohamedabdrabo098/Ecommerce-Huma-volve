import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dummy_data.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/widgets/api/api_client.dart';
import '../data/datasources/home_remote_data_source.dart';
import '../data/repositories/home_repository_impl.dart';
import '../domain/usecases/get_categories_usecase.dart';
import '../domain/usecases/get_products_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    GetCategoriesUseCase? getCategoriesUseCase,
    GetProductsUseCase? getProductsUseCase,
  })  : getCategoriesUseCase = getCategoriesUseCase ??
            GetCategoriesUseCase(
              HomeRepositoryImpl(
                remoteDataSource: HomeRemoteDataSourceImpl(
                  apiClient: ApiClient(),
                ),
              ),
            ),
        getProductsUseCase = getProductsUseCase ??
            GetProductsUseCase(
              HomeRepositoryImpl(
                remoteDataSource: HomeRemoteDataSourceImpl(
                  apiClient: ApiClient(),
                ),
              ),
            ),
        super(HomeInitial());

  int selectedCategoryIndex = 0;
  String searchQuery = '';
  List<String> categories = [];
  List<Product> allProducts = [];
  List<Product> products = [];

  Future<void> getCategories() async {
    if (!isClosed) emit(CategoryLoading());
    try {
      categories = await getCategoriesUseCase(const NoParams());
      if (!isClosed) emit(CategorySuccess(categories));
    } catch (e) {
      if (!isClosed) emit(CategoryError(e.toString()));
    }
  }

  Future<void> getProducts() async {
    if (!isClosed) emit(ProductLoading());
    try {
      allProducts = await getProductsUseCase(const NoParams());
      _applyFilters();
    } catch (e) {
      if (!isClosed) emit(ProductError(e.toString()));
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    emit(CategorySuccess(categories));
    _applyFilters();
  }

  void searchProducts(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    List<Product> filtered = allProducts;

    // If searching, search globally across all products
    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      filtered = filtered.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query) ||
            p.categoryName.toLowerCase().contains(query);
      }).toList();
    } else {
      // If not searching, filter by the selected category
      if (categories.isNotEmpty &&
          selectedCategoryIndex < categories.length &&
          categories[selectedCategoryIndex] != 'All') {
        final selectedCategory = categories[selectedCategoryIndex];
        filtered = filtered
            .where((p) => p.categoryName == selectedCategory)
            .toList();
      }
    }

    products = filtered;
    if (products.isEmpty) {
      if (searchQuery.trim().isNotEmpty) {
        if (!isClosed) emit(ProductError('No products found matching "$searchQuery"'));
      } else {
        if (!isClosed) emit(ProductError('No products found in this category'));
      }
    } else {
      if (!isClosed) emit(ProductSuccess(products));
    }
  }
}
