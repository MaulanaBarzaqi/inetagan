import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inetagan/features/subscribe/data/models/subscribe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SubscribeLocalDatasource {
  Future<void> cacheSubscription(SubscribeModel subscription);
  Future<SubscribeModel?> getCachedSubscription();
  Future<void> clearCachedSubscription();
}

class SubscribeLocalDatasourceImpl implements SubscribeLocalDatasource {
  final SharedPreferences sharedPreferences;

  SubscribeLocalDatasourceImpl(this.sharedPreferences);

  static const String _cachedSubscriptionKey = 'cached_subscription';

  @override
  Future<void> cacheSubscription(SubscribeModel subscription) async {
    try {
      final subscriptionJson = subscription.toJsonRead();
      final subscriptionString = jsonEncode(subscriptionJson);
      await sharedPreferences.setString(
        _cachedSubscriptionKey,
        subscriptionString,
      );
    } catch (e) {
      throw Exception('Failed to cache subscription: $e');
    }
  }

  @override
  Future<SubscribeModel?> getCachedSubscription() async {
    try {
      final subscriptionString = sharedPreferences.getString(
        _cachedSubscriptionKey,
      );
      if (subscriptionString == null || subscriptionString.isEmpty) {
        return null;
      }

      final subscriptionJson = jsonDecode(subscriptionString);
      if (subscriptionJson == null) {
        return null;
      }
      return SubscribeModel.fromJsonRead(subscriptionJson);
    } catch (e) {
      debugPrint('Error getting cached subscription: $e');
      return null;
    }
  }

  @override
  Future<void> clearCachedSubscription() async {
    try {
      await sharedPreferences.remove(_cachedSubscriptionKey);
    } catch (e) {
      throw Exception('Failed to clear cached subscription: $e');
    }
  }
}
