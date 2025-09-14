import 'package:equatable/equatable.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/profile/domain/entities/user_entity.dart';

class SubscribeEntity extends Equatable {
  final int id;
  final String name;
  final String nik;
  final String phone;
  final String address;
  final String? status;
  final int userId;
  final int internetPackageId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final InternetPackageEntity? internetPackage;
  final UserEntity? user;

  const SubscribeEntity({
    required this.id,
    required this.name,
    required this.nik,
    required this.phone,
    required this.address,
    this.status,
    required this.userId,
    required this.internetPackageId,
    required this.updatedAt,
    required this.createdAt,
    this.internetPackage,
    this.user,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      nik,
      phone,
      address,
      status,
      userId,
      internetPackageId,
      updatedAt,
      createdAt,
      internetPackage,
      user,
    ];
  }
}
