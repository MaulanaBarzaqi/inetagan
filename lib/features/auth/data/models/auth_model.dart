import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    required super.updatedAt,
    super.token,
    super.role,
    super.deviceToken,
    super.emailVerifiedAt,
  });

  factory AuthModel.fromLoginJson(Map<String, dynamic> json) {
    final data = json['data'];
    return AuthModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      role: data['role'],
      deviceToken: data['device_token'],
      emailVerifiedAt: data['email_verified_at'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
      token: json['token'],
    );
  }

  factory AuthModel.fromRegisterJson(Map<String, dynamic> json) {
    final data = json['data'];
    return AuthModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      deviceToken: json['device_token'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'device_token': deviceToken,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'token': token,
    };
  }
}
