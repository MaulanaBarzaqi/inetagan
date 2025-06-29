// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class InternetplanEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String category;
  final String speed;
  final String idealDevice;
  final int installation;
  final int monthlyBill;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InternetplanEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    required this.speed,
    required this.idealDevice,
    required this.installation,
    required this.monthlyBill,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      category,
      speed,
      idealDevice,
      installation,
      monthlyBill,
      image,
      createdAt,
      updatedAt,
    ];
  }
}
