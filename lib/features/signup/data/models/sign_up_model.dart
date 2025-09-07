import 'package:inetagan/features/signup/domain/entities/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  const SignUpModel({
    required super.id,
    required super.uuid,
    required super.name,
    required super.email,
    required super.updatedAt,
    required super.createdAt,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SignUpModel(
      id: data['id'],
      uuid: data['uuid'],
      name: data['name'],
      email: data['email'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'uuid': uuid,
        'name': name,
        'email': email,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      },
    };
  }
}
