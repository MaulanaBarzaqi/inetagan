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
}
