import 'package:inetagan/features/signin/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  const SignInModel({
    required super.id,
    required super.uuid,
    required super.name,
    required super.email,
    required super.role,
    super.regionId,
    super.deviceToken,
    super.emailVerifiedAt,
    required super.createdAt,
    required super.updatedAt,
    required super.token,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return SignInModel(
      id: data['id'],
      uuid: data['uuid'],
      name: data['name'],
      email: data['email'],
      role: data['role'],
      regionId: data['region_id'],
      deviceToken: data['device_token'],
      emailVerifiedAt: data['email_verified_at'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
      token: json['token'],
    );
  }

  factory SignInModel.fromJsonRead(Map<String, dynamic> json) {
    return SignInModel(
      id: json['id'],
      uuid: json['uuid'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      regionId: json['region_id'],
      deviceToken: json['device_token'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'uuid': uuid,
        'name': name,
        'email': email,
        'role': role,
        'region_id': regionId,
        'device_token': deviceToken,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      },
      'token': token,
    };
  }
}
