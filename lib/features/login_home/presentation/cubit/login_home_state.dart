part of 'login_home_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginHomeInitial extends LoginState {}

class ChangeIcon extends LoginState {}

class Loading extends LoginState {}

class LoginError extends LoginState {
  final ErrorModel error;

  const LoginError(this.error);
}

class LoginSuccess extends LoginState {
  final LoginEntities login;

  const LoginSuccess(this.login);
}
