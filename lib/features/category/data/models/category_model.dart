import 'package:inetagan/features/category/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.description,
    super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"] as String?,
    deletedAt: json["deleted_at"] != null
        ? DateTime.parse(json['deleted_at'])
        : null,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "deleted_at": deletedAt?.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  CategoryEntity get toEntity => CategoryEntity(
    id: id,
    name: name,
    slug: slug,
    description: description,
    deletedAt: deletedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
