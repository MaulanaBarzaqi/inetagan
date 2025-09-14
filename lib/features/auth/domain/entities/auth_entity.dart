import 'package:equatable/equatable.dart';
import 'package:inetagan/features/profile/domain/entities/user_entity.dart';

class AuthEntity extends Equatable {
  final UserEntity data;
  final String? token;

  const AuthEntity({required this.data, this.token});

  @override
  List<Object?> get props => [data, token];
}
