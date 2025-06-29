import 'dart:convert';

import 'package:inetagan/features/auth/data/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<AuthModel?> getUser();
  Future<void> saveUser(AuthModel user);
  Future<void> removeUser();

  Future<String?> getBearerToken();
  Future<void> saveBearerToken(String bearerToken);
  Future<void> removeBearerToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const _userKey = 'data';
  static const _tokenKey = 'token';

  // user
  @override
  Future<AuthModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final userString = pref.getString(_userKey);
    if (userString == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userString);
    return AuthModel.fromJson(userMap);
  }

  @override
  Future<void> saveUser(AuthModel user) async {
    final pref = await SharedPreferences.getInstance();
    final userString = jsonEncode(user.toJson());
    await pref.setString(_userKey, userString);
  }

  @override
  Future<void> removeUser() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_userKey);
  }

  // token
  @override
  Future<String?> getBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  @override
  Future<void> saveBearerToken(String bearerToken) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, bearerToken);
  }

  @override
  Future<void> removeBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_tokenKey);
  }
}
