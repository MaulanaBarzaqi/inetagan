import 'dart:convert';

import 'package:inetagan/features/auth/data/models/user_model.dart';
import 'package:inetagan/features/auth/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({required super.data});

  factory RegisterModel.fromJson(String str) =>
      RegisterModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromMap(Map<String, dynamic> json) =>
      RegisterModel(data: UserModel.fromMap(json["data"]));

  Map<String, dynamic> toMap() => {"data": (data as UserModel).toMap()};
}
