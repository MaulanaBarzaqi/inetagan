import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';

class SubscribeModel extends SubscribeEntity {
  const SubscribeModel({
    required super.id,
    required super.name,
    required super.nik,
    required super.phone,
    required super.address,
    required super.userId,
    required super.internetPackageId,
    required super.updatedAt,
    required super.createdAt,
  });
  factory SubscribeModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SubscribeModel(
      id: data["id"],
      name: data["name"],
      nik: data["nik"],
      phone: data["phone"],
      address: data["address"],
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
    "user_id": userId,
    "internet_package_id": internetPackageId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
