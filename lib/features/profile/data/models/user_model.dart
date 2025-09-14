import 'package:inetagan/features/auth/data/models/auth_model.dart';
import 'package:inetagan/features/profile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.uuid,
    required super.name,
    required super.email,
    super.role,
    super.regionId,
    super.deviceToken,
    super.emailVerifiedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    regionId: json["region_id"],
    deviceToken: json["device_token"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  factory UserModel.fromAuthModel(AuthModel authModel) {
    final user = authModel.data;
    return UserModel(
      id: user.id,
      uuid: user.uuid,
      name: user.name,
      email: user.email,
      role: user.role,
      regionId: user.regionId,
      deviceToken: user.deviceToken,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "email": email,
    "role": role,
    "region_id": regionId,
    "device_token": deviceToken,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
