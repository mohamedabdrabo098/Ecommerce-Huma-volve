import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/api/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({LoginUseCase? loginUseCase})
      : loginUseCase = loginUseCase ??
            LoginUseCase(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(
                  apiClient: ApiClient(),
                ),
              ),
            ),
        super(LoginInitial());

  Future<void> login(String email, String password) async {
    if (!isClosed) emit(LoginLoading());
    try {
      final token = await loginUseCase(
        LoginParams(email: email, password: password),
      );
      if (!isClosed) emit(LoginSuccess(token));
    } catch (e) {
      String errorMessage = 'Login failed. Please check your credentials.';
      if (e.toString().contains('401')) {
        errorMessage = 'Invalid email or password (401 Unauthorized)';
      } else if (e.toString().contains('SocketException') || e.toString().contains('connection')) {
        errorMessage = 'Network error. Please check your internet connection.';
      }
      if (!isClosed) emit(LoginError(errorMessage));
    }
  }
}

