import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/api/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpCubit({SignUpUseCase? signUpUseCase})
      : signUpUseCase = signUpUseCase ??
            SignUpUseCase(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(
                  apiClient: ApiClient(),
                ),
              ),
            ),
        super(SignUpInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    String avatar = 'https://i.imgur.com/LDOO4Qs.jpg',
  }) async {
    emit(SignUpLoading());
    try {
      final user = await signUpUseCase(
        SignUpParams(
          name: name,
          email: email,
          password: password,
          avatar: avatar,
        ),
      );
      emit(SignUpSuccess(user));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}

