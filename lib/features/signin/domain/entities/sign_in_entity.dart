import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final int id;
  final String uuid;
  final String name;
  final String email;
  final String role;
  final int? regionId;
  final String? deviceToken;
  final DateTime? emailVerifiedAt;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String token;

  const SignInEntity({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.role,
    this.regionId,
    this.deviceToken,
    this.emailVerifiedAt,
    required this.updatedAt,
    required this.createdAt,
    required this.token,
  });

  @override
  List<Object?> get props => [
    id,
    uuid,
    name,
    email,
    role,
    regionId,
    deviceToken,
    emailVerifiedAt,
    updatedAt,
    createdAt,
    token,
  ];
}
