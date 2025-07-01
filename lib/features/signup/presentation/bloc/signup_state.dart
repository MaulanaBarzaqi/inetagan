part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpSuccess extends SignupState {
  final SignUpEntity data;

  const SignUpSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class SignUpFailed extends SignupState {
  final String message;

  const SignUpFailed(this.message);

  @override
  List<Object> get props => [message];
}
