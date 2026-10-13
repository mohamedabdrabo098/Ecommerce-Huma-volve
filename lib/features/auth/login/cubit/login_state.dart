import '../../domain/entities/auth_token_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthTokenEntity token;
  LoginSuccess(this.token);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

