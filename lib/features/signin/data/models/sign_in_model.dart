import 'package:inetagan/features/signin/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  const SignInModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.deviceToken,
    super.emailVerifiedAt,
    required super.createdAt,
    required super.updatedAt,
    required super.token,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SignInModel(
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

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'device_token': deviceToken,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      },
      'token': token,
    };
  }
}
