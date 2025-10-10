import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inetagan/features/auth/data/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<AuthModel?> getCachedUser();
  Future<void> cacheUser(AuthModel user);
  Future<void> clearUserData();

  Future<String?> getCachedToken();
  Future<void> cacheToken(String bearerToken);
  Future<void> removeToken();

  Future<bool> isFirstTimeInstall();
  Future<void> markAppAsLauched();
  Future<String?> determineRedirectRoute();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences pref;

  AuthLocalDatasourceImpl(this.pref);

  static const _cachedUserKey = 'data';
  static const _cachedTokenKey = 'token';
  static const _firstTimeInstallKey = 'first_time_install';

  // user
  @override
  Future<AuthModel?> getCachedUser() async {
    final userString = pref.getString(_cachedUserKey);
    if (userString == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userString);
    return AuthModel.fromJson(userMap);
  }

  @override
  Future<void> cacheUser(AuthModel user) async {
    final userString = jsonEncode(user.toJson());
    await pref.setString(_cachedUserKey, userString);
  }

  @override
  Future<void> clearUserData() async {
    try {
      await pref.remove(_cachedUserKey);
    } catch (e) {
      debugPrint('Error clearing user data: $e');
      throw Exception('Failed to clear user data');
    }
  }

  // token
  @override
  Future<String?> getCachedToken() async {
    try {
      return Future.value(pref.getString(_cachedTokenKey));
    } catch (e) {
      debugPrint('Error getting cached token: $e');
      return Future.value(null);
    }
  }

  @override
  Future<void> cacheToken(String bearerToken) async {
    try {
      await pref.setString(_cachedTokenKey, bearerToken);
    } catch (e) {
      debugPrint('Error caching token: $e');
      throw Exception('Failed to cache token');
    }
  }

  @override
  Future<void> removeToken() async {
    try {
      await pref.remove(_cachedTokenKey);
    } catch (e) {
      debugPrint('Error removing token: $e');
      throw Exception('Failed to remove token');
    }
  }

  // handle redirect
  @override
  Future<bool> isFirstTimeInstall() async {
    try {
      return Future.value(!pref.containsKey(_firstTimeInstallKey));
    } catch (e) {
      debugPrint('error checking first time install: $e');
      return true;
    }
  }

  @override
  Future<void> markAppAsLauched() async {
    try {
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
        return '/home';
      }
      return '/signin';
    } catch (e) {
      debugPrint('Error determining redirect route: $e');
      return null;
    }
  }
}
