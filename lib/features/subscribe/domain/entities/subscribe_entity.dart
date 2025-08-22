// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SubscribeEntity extends Equatable {
  final int id;
  final String name;
  final String nik;
  final String phone;
  final String address;
  final int userId;
  final String internetPackageId;
  final DateTime updatedAt;
  final DateTime createdAt;

  const SubscribeEntity({
    required this.id,
    required this.name,
    required this.nik,
    required this.phone,
    required this.address,
    required this.userId,
    required this.internetPackageId,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      nik,
      phone,
      address,
      userId,
      internetPackageId,
      updatedAt,
      createdAt,
    ];
  }
}
