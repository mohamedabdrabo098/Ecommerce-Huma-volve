import '../../../../core/dummy_data.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class GetProductsUseCase implements UseCase<List<Product>, NoParams> {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<List<Product>> call(NoParams params) {
    return repository.getProducts();
  }
}

