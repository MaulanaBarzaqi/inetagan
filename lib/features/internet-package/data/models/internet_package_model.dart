import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';

class InternetPackageModel extends InternetPackageEntity {
  const InternetPackageModel({
    required super.id,
    required super.name,
    required super.category,
    required super.speed,
    required super.idealDevice,
    required super.installation,
    required super.monthlyBill,
    super.image,
    super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory InternetPackageModel.fromJson(Map<String, dynamic> json) =>
      InternetPackageModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        speed: json["speed"],
        idealDevice: json["ideal_device"],
        installation: json["installation"],
        monthlyBill: json["monthly_bill"],
        image: json["image"],
        deletedAt: json["deleted_at"] != null
            ? DateTime.parse(json["deleted_at"])
            : null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "speed": speed,
    "ideal_device": idealDevice,
    "installation": installation,
    "monthly_bill": monthlyBill,
    "image": image,
    "deleted_at": deletedAt?.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  InternetPackageEntity get toEntity => InternetPackageEntity(
    id: id,
    name: name,
    category: category,
    speed: speed,
    idealDevice: idealDevice,
    installation: installation,
    monthlyBill: monthlyBill,
    image: image,
    deletedAt: deletedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
