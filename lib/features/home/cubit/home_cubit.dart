import 'package:ecommerce_app_huma_volve/core/widgets/api/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/api_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dummy_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiHome apiHome;

  HomeCubit({ApiHome? apiHome})
      : apiHome = apiHome ?? ApiHome(apiClient: ApiClient()),
        super(HomeInitial());

  int selectedCategoryIndex = 0;
  List<String> categories = [];
  List<Product> allProducts = [];
  List<Product> products = [];

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      categories = await apiHome.getCategories();
      emit(CategorySuccess(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      allProducts = await apiHome.getProducts();
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

