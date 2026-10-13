import '../entities/auth_token_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthTokenEntity> login(String email, String password);

  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
    String avatar = 'https://i.imgur.com/LDOO4Qs.jpg',
  });
}

