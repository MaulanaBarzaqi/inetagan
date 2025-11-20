part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final AuthEntity data;

  const SignUpSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class SignUpFailed extends SignUpState {
  final Failure failure;

  const SignUpFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
