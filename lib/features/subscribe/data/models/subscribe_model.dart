import 'package:inetagan/features/internet-package/data/models/internet_package_model.dart';
import 'package:inetagan/features/signin/data/models/sign_in_model.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';

class SubscribeModel extends SubscribeEntity {
  const SubscribeModel({
    required super.id,
    required super.name,
    required super.nik,
    required super.phone,
    required super.address,
    super.status,
    required super.userId,
    required super.internetPackageId,
    required super.updatedAt,
    required super.createdAt,
    super.internetPackage,
    super.user,
  });

  // POST
  factory SubscribeModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SubscribeModel(
      id: data["id"],
      name: data["name"],
      nik: data["nik"],
      phone: data["phone"],
      address: data["address"],
      status: data["status"],
      userId: data["user_id"],
      internetPackageId: data["internet_package_id"],
      updatedAt: DateTime.parse(data["updated_at"]),
      createdAt: DateTime.parse(data["created_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nik": nik,
    "phone": phone,
    "address": address,
    "status": status,
    "user_id": userId,
    "internet_package_id": internetPackageId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };

  // READ
  factory SubscribeModel.fromJsonRead(Map<String, dynamic> json) {
    final data = json['data'];
    return SubscribeModel(
      id: data["id"],
      name: data["name"],
      nik: data["nik"],
      phone: data["phone"],
      address: data["address"],
      status: data["status"],
      userId: data["user_id"],
      internetPackageId: data["internet_package_id"],
      updatedAt: DateTime.parse(data["updated_at"]),
      createdAt: DateTime.parse(data["created_at"]),
      internetPackage: data["internet_package"] != null
          ? InternetPackageModel.fromJson(data["internet_package"])
          : null,
      user: data["user"] != null
          ? SignInModel.fromJsonRead(data["user"])
          : null,
    );
  }

  Map<String, dynamic> toJsonRead() => {
    "id": id,
    "name": name,
    "nik": nik,
    "phone": phone,
    "address": address,
    "status": status,
    "user_id": userId,
    "internet_package_id": internetPackageId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "internet_package": internetPackage != null
        ? (internetPackage as InternetPackageModel).toJson()
        : null,
    "user": user != null ? (user as SignInModel).toJson() : null,
  };
}
