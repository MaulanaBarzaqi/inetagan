import 'package:equatable/equatable.dart';
import 'package:inetagan/features/category/domain/entities/category_entity.dart';

class InternetPackageEntity extends Equatable {
  final int id;
  final String name;
  final CategoryEntity? category;
  final String speed;
  final String idealDevice;
  final int installation;
  final int monthlyBill;
  final String? image;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InternetPackageEntity({
    required this.id,
    required this.name,
    this.category,
    required this.speed,
    required this.idealDevice,
    required this.installation,
    required this.monthlyBill,
    this.image,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      category,
      speed,
      idealDevice,
      installation,
      monthlyBill,
      image,
      deletedAt,
      createdAt,
      updatedAt,
    ];
  }

  bool get hasImage => image != null && image!.isNotEmpty;

  bool get isDeleted => deletedAt != null;
}
