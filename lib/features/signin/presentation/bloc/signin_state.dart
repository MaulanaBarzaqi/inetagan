part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SigninState {}

class SignInLoading extends SigninState {}

class SignInSuccess extends SigninState {
  final SignInEntity data;

  const SignInSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class SignInFailed extends SigninState {
  final String message;

  const SignInFailed(this.message);

  @override
  List<Object> get props => [message];
}
