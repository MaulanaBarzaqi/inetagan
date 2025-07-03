import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';

class InternetplanModel extends InternetplanEntity {
  const InternetplanModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.category,
    required super.speed,
    required super.idealDevice,
    required super.installation,
    required super.monthlyBill,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
  });

  factory InternetplanModel.fromJson(Map<String, dynamic> json) =>
      InternetplanModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        category: json["category"],
        speed: json["speed"],
        idealDevice: json["ideal_device"],
        installation: json["installation"],
        monthlyBill: json["monthly_bill"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "category": category,
    "speed": speed,
    "ideal_device": idealDevice,
    "installation": installation,
    "monthly_bill": monthlyBill,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  InternetplanEntity get toEntity => InternetplanEntity(
    id: id,
    name: name,
    slug: slug,
    category: category,
    speed: speed,
    idealDevice: idealDevice,
    installation: installation,
    monthlyBill: monthlyBill,
    image: image,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
