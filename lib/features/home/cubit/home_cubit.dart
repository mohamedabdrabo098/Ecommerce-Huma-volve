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
  List<String> categories = [];
  List<Product> allProducts = [];
  List<Product> products = [];

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      categories = await getCategoriesUseCase(const NoParams());
      emit(CategorySuccess(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      allProducts = await getProductsUseCase(const NoParams());
      products = allProducts;
      if (products.isEmpty) {
        emit(ProductError('No products found'));
      } else {
        emit(ProductSuccess(products));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    if (categories.isEmpty || categories[index] == 'All') {
      products = allProducts;
    } else {
      final selectedCategory = categories[index];
      products = allProducts
          .where((p) => p.categoryName == selectedCategory)
          .toList();
    }
    emit(CategorySuccess(categories));
    if (products.isEmpty) {
      emit(ProductError('No products found in this category'));
    } else {
      emit(ProductSuccess(products));
    }
  }
}
