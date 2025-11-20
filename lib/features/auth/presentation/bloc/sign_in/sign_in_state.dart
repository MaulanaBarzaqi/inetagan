part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final AuthEntity data;

  const SignInSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class SignInFailed extends SignInState {
  final Failure failure;

  const SignInFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
