part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserEntity data;
  final String token;

  const LoginSuccess({required this.data, required this.token});

  @override
  List<Object> get props => [data, token];
}

class LoginFailed extends LoginState {
  final String errorMessage;

  const LoginFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
