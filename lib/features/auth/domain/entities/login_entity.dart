import 'package:equatable/equatable.dart';
import 'package:inetagan/features/auth/domain/entities/user_entity.dart';

class LoginEntity extends Equatable {
  final UserEntity data;
  final String token;

  const LoginEntity({required this.data, required this.token});

  @override
  List<Object> get props => [data, token];
}
