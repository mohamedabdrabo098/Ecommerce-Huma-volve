import '../../../../core/widgets/api/api_client.dart';
import '../../../../core/widgets/api/api_constants.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> login(String email, String password);
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    required String avatar,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AuthTokenModel> login(String email, String password) async {
    final response = await apiClient.dio.post(
      ApiConstants.loginEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthTokenModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    required String avatar,
  }) async {
    final response = await apiClient.dio.post(
      ApiConstants.registerEndpoint,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'avatar': avatar,
      },
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}

