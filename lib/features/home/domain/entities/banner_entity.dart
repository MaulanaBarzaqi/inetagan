import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final int id;
  final String title;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BannerEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, title, image, createdAt, updatedAt];
}
