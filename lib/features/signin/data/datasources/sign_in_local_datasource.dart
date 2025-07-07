import 'dart:convert';

import 'package:inetagan/common/routes.dart';
import 'package:inetagan/features/signin/data/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignInLocalDatasource {
  Future<SignInModel?> getUser();
  Future<void> saveUser(SignInModel user);
  Future<void> removeUser();

  Future<String?> getBearerToken();
  Future<void> saveBearerToken(String bearerToken);
  Future<void> removeBearerToken();

  Future<bool> hasLaunched();
  Future<void> setHasLaunched();
  Future<String?> getRedirectRoute();
}

class SignInLocalDatasourceImpl implements SignInLocalDatasource {
  static const _userKey = 'data';
  static const _tokenKey = 'token';
  static const _lauchKey = 'hasLaunched';

  // user
  @override
  Future<SignInModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final userString = pref.getString(_userKey);
    if (userString == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userString);
    return SignInModel.fromJson(userMap);
  }

  @override
  Future<void> saveUser(SignInModel user) async {
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

  // handling redirect
  @override
  Future<bool> hasLaunched() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_lauchKey) ?? false;
  }

  @override
  Future<void> setHasLaunched() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_lauchKey, true);
  }

  @override
  Future<String?> getRedirectRoute() async {
    final token = await getBearerToken();
    final launched = await hasLaunched();

    if (token != null && token.isNotEmpty) {
      return RouteNames.dashboard;
    } else if (launched) {
      return RouteNames.signin;
    }
    return null;
  }
}
