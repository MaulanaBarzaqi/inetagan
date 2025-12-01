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
    super.internetInstallationId,
    super.fcmToken,
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
    regionId: json["region_id"] == null
        ? null
        : int.tryParse(json["region_id"].toString()),
    internetInstallationId: json['internet_installation_id'] == null
        ? null
        : int.tryParse(json['internet_installation_id'].toString()),
    fcmToken: json["fcm_token"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "email": email,
    "role": role,
    "region_id": regionId,
    "internet_installation_id": internetInstallationId,
    "fcm_token": fcmToken,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  factory UserModel.fromAuthModel(AuthModel authModel) {
    final user = authModel.data;
    return UserModel(
      id: user.id,
      uuid: user.uuid,
      name: user.name,
      email: user.email,
      role: user.role,
      regionId: user.regionId,
      internetInstallationId: user.internetInstallationId,
      fcmToken: user.fcmToken,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
