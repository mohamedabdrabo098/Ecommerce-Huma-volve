import '../../domain/entities/auth_token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthTokenEntity> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
    String avatar = 'https://i.imgur.com/LDOO4Qs.jpg',
  }) {
    return remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
      avatar: avatar,
    );
  }
}

