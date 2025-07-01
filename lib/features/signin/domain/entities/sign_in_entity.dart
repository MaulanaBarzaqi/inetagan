import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? deviceToken;
  final String? emailVerifiedAt;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String token;

  const SignInEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.deviceToken,
    this.emailVerifiedAt,
    required this.updatedAt,
    required this.createdAt,
    required this.token,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    role,
    deviceToken,
    emailVerifiedAt,
    updatedAt,
    createdAt,
    token,
  ];
}
