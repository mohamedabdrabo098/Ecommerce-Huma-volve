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
    emit(LoginLoading());
    try {
      final token = await loginUseCase(
        LoginParams(email: email, password: password),
      );
      emit(LoginSuccess(token));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}

