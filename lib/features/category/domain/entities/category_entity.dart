import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [id, name, slug, description, deletedAt, createdAt, updatedAt];
  }
}
