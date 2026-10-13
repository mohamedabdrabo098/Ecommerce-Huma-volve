import '../../domain/entities/user_entity.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final UserEntity user;
  SignUpSuccess(this.user);
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}

