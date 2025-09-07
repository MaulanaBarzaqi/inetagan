// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final int id;
  final String uuid;
  final String name;
  final String email;
  final DateTime updatedAt;
  final DateTime createdAt;

  const SignUpEntity({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [id, uuid, name, email, updatedAt, createdAt];
  }
}
