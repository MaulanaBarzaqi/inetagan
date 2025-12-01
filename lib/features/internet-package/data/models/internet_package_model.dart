import 'package:inetagan/features/category/data/models/category_model.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';

class InternetPackageModel extends InternetPackageEntity {
  const InternetPackageModel({
    required super.id,
    required super.name,
    super.category,
    required super.speed,
    required super.idealDevice,
    required super.installation,
    required super.monthlyBill,
    super.image,
    super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory InternetPackageModel.fromJson(Map<String, dynamic> json) {
    return InternetPackageModel(
      id: json["id"],
      name: json["name"],
      category: json["category"] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      speed: json["speed"],
      idealDevice: json["ideal_device"],
      installation: int.parse(json["installation"] as String),
      monthlyBill: int.parse(json["monthly_bill"] as String),
      image: json["image"],
      deletedAt: json["deleted_at"] != null
          ? DateTime.parse(json["deleted_at"])
          : null,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category != null
          ? (category as CategoryModel).toJson()
          : null,
      "speed": speed,
      "ideal_device": idealDevice,
      "installation": installation,
      "monthly_bill": monthlyBill,
      "image": image,
      "deleted_at": deletedAt?.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }

  InternetPackageEntity get toEntity => InternetPackageEntity(
    id: id,
    name: name,
    category: category != null ? (category as CategoryModel).toEntity : null,
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
