import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? token;
  final String? role;
  final String? deviceToken;
  final String? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AuthEntity({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.role,
    this.deviceToken,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    token,
    role,
    deviceToken,
    emailVerifiedAt,
    createdAt,
    updatedAt,
  ];
}
