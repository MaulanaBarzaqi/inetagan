part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserEntity data;

  const RegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class RegisterFailed extends RegisterState {
  final String errorMessage;

  const RegisterFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
