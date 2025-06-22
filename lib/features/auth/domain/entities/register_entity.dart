import 'package:equatable/equatable.dart';
import 'package:inetagan/features/auth/domain/entities/user_entity.dart';

class RegisterEntity extends Equatable {
  final UserEntity data;

  const RegisterEntity({required this.data});

  @override
  List<Object> get props => [data];
}
