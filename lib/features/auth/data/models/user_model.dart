import 'dart:convert';
import 'package:inetagan/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    String? deviceToken,
    String? emailVerifiedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    deviceToken:
        json.containsKey("device_token") && json["device_token"] != null
        ? json["device_token"].toString()
        : null,
    emailVerifiedAt:
        json.containsKey("email_verified_at") &&
            json["email_verified_at"] != null
        ? json["email_verified_at"].toString()
        : null,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "device_token": deviceToken,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
