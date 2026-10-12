import '../../../core/dummy_data.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

// Product States
class ProductLoading extends HomeState {}

class ProductSuccess extends HomeState {
  final List<Product> products;

  ProductSuccess(this.products);
}

class ProductError extends HomeState {
  final String message;

  ProductError(this.message);
}

// Category States
class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<String> categories;

  CategorySuccess(this.categories);
}

class CategoryError extends HomeState {
  final String message;

  CategoryError(this.message);
}

