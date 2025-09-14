import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:inetagan/features/profile/data/models/user_model.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.data, super.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      data: UserModel.fromJson(json['data']),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': (data as UserModel).toJson(),
      if (token != null) 'token': token,
    };
  }
}
