import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String uuid;
  final String name;
  final String email;
  final String? role;
  final int? regionId;
  final int? internetInstallationId;
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
    this.internetInstallationId,
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
      internetInstallationId,
      deviceToken,
      emailVerifiedAt,
      createdAt,
      updatedAt,
    ];
  }

  bool get hasActiveInstallation => internetInstallationId != null;
}
