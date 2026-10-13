import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class GetCategoriesUseCase implements UseCase<List<String>, NoParams> {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<List<String>> call(NoParams params) {
    return repository.getCategories();
  }
}

