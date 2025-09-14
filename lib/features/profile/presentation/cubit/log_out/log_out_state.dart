part of 'log_out_cubit.dart';

sealed class LogOutState extends Equatable {
  const LogOutState();

  @override
  List<Object> get props => [];
}

final class LogOutInitial extends LogOutState {}

class LogOutLoading extends LogOutState {}

class LogOutSuccess extends LogOutState {}

class LogOutError extends LogOutState {
  final String message;

  const LogOutError(this.message);
}
