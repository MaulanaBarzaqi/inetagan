part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class OnRegisterEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  const OnRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [name, email, password];
}
