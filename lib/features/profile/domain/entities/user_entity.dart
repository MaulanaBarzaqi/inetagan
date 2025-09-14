import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String uuid;
  final String name;
  final String email;
  final String? role;
  final int? regionId;
  final String? deviceToken;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    this.role,
    this.regionId,
    this.deviceToken,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      uuid,
      name,
      email,
      role,
      regionId,
      deviceToken,
      emailVerifiedAt,
      createdAt,
      updatedAt,
    ];
  }
}
