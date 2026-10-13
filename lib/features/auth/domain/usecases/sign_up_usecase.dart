import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpParams {
  final String name;
  final String email;
  final String password;
  final String avatar;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    this.avatar = 'https://i.imgur.com/LDOO4Qs.jpg',
  });
}

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<UserEntity> call(SignUpParams params) {
    return repository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
      avatar: params.avatar,
    );
  }
}

