import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/features/signin/data/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignInLocalDatasource {
  Future<SignInModel?> getCachedUser();
  Future<void> cacheUser(SignInModel user);
  Future<void> clearUserData();

  Future<String?> getCachedToken();
  Future<void> cacheToken(String bearerToken);
  Future<void> removeToken();

  Future<bool> isFirstTimeInstall();
  Future<void> markAppAsLauched();
  Future<String?> determineRedirectRoute();
}

class SignInLocalDatasourceImpl implements SignInLocalDatasource {
  static const _cachedUserKey = 'data';
  static const _cachedTokenKey = 'token';
  static const _firstTimeInstallKey = 'first_time_install';

  // user
  @override
  Future<SignInModel?> getCachedUser() async {
    final pref = await SharedPreferences.getInstance();
    final userString = pref.getString(_cachedUserKey);
    if (userString == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userString);
    return SignInModel.fromJson(userMap);
  }

  @override
  Future<void> cacheUser(SignInModel user) async {
    final pref = await SharedPreferences.getInstance();
    final userString = jsonEncode(user.toJson());
    await pref.setString(_cachedUserKey, userString);
  }

  @override
  Future<void> clearUserData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_cachedUserKey);
  }

  // token
  @override
  Future<String?> getCachedToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_cachedTokenKey);
  }

  @override
  Future<void> cacheToken(String bearerToken) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_cachedTokenKey, bearerToken);
  }

  @override
  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_cachedTokenKey);
  }

  // handle redirect
  @override
  Future<bool> isFirstTimeInstall() async {
    try {
      final pref = await SharedPreferences.getInstance();
      return !pref.containsKey(_firstTimeInstallKey);
    } catch (e) {
      debugPrint('error checking first time install: $e');
      return true;
    }
  }

  @override
  Future<void> markAppAsLauched() async {
    try {
      final pref = await SharedPreferences.getInstance();
      await pref.setBool(_firstTimeInstallKey, false);
    } catch (e) {
      debugPrint('Error marking app as launched: $e');
      throw Exception('Failed to mark app as launched');
    }
  }

  @override
  Future<String?> determineRedirectRoute() async {
    try {
      final token = await getCachedToken();
      final isFirstTime = await isFirstTimeInstall();

      if (isFirstTime) {
        return null;
      }
      if (token != null && token.isNotEmpty) {
        return RouteNames.dashboard;
      }
      return RouteNames.signin;
    } catch (e) {
      debugPrint('Error determining redirect route: $e');
      return null;
    }
  }

  // handling redirect
  // @override
  // Future<bool> hasLaunched() async {
  //   final pref = await SharedPreferences.getInstance();
  //   return pref.getBool(_lauchKey) ?? false;
  // }

  // @override
  // Future<void> setHasLaunched() async {
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setBool(_lauchKey, true);
  // }

  // @override
  // Future<String?> getRedirectRoute() async {
  //   final token = await getCachedToken();
  //   final launched = await hasLaunched();

  //   if (token != null && token.isNotEmpty) {
  //     return RouteNames.dashboard;
  //   } else if (launched) {
  //     return RouteNames.signin;
  //   }
  //   return null;
  // }
}
