import 'dart:convert';

import 'package:inetagan/features/auth/data/models/user_model.dart';
import 'package:inetagan/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.data, required super.token});

  factory LoginModel.fromJson(String str) =>
      LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) =>
      LoginModel(data: UserModel.fromMap(json["data"]), token: json["token"]);

  Map<String, dynamic> toMap() => {
    "data": (data as UserModel).toMap(),
    "token": token,
  };
}
