import 'dart:convert';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/features/internet-package/data/models/internet_package_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InternetPackageLocalDatasource {
  Future<List<InternetPackageModel>> getCachedInternetPackages();
  Future<void> cacheInternetPackages(List<InternetPackageModel> packages);
  Future<void> clearInternetPackagesCache();
  Future<bool> hasCachedInternetPackages();
}

class InternetPackageLocalDatasourceImpl
    implements InternetPackageLocalDatasource {
  final SharedPreferences prefs;

  InternetPackageLocalDatasourceImpl(this.prefs);

  static const _cacheInternetPackagesKey = 'cached_internet_packages';
  static const _cacheTimestampKey = 'internet_package_cache_timestamp';
  static const Duration cacheDuration = Duration(hours: 1);

  @override
  Future<List<InternetPackageModel>> getCachedInternetPackages() async {
    try {
      final cachedData = prefs.getString(_cacheInternetPackagesKey);
      final cachedTime = prefs.getInt(_cacheTimestampKey);

      if (cachedData == null || cachedTime == null) {
        throw CachedException('No cached internet packages found');
      }

      final cacheDateTime = DateTime.fromMillisecondsSinceEpoch(cachedTime);
      if (DateTime.now().difference(cacheDateTime) > cacheDuration) {
        await clearInternetPackagesCache();
        throw CachedException('Cache expired');
      }

      final List<dynamic> jsonList = jsonDecode(cachedData);
      return jsonList
          .map((json) => InternetPackageModel.fromJson(json))
          .toList();
    } catch (e) {
      throw CachedException('Failed to read from cache: $e');
    }
  }

  @override
  Future<void> cacheInternetPackages(
    List<InternetPackageModel> packages,
  ) async {
    try {
      final jsonList = packages.map((package) => package.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await prefs.setString(_cacheInternetPackagesKey, jsonString);
      await prefs.setInt(
        _cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      throw CachedException('Failed to cache internet packages: $e');
    }
  }

  @override
  Future<void> clearInternetPackagesCache() async {
    await prefs.remove(_cacheInternetPackagesKey);
    await prefs.remove(_cacheTimestampKey);
  }

  @override
  Future<bool> hasCachedInternetPackages() async {
    return prefs.containsKey(_cacheInternetPackagesKey) &&
        prefs.containsKey(_cacheTimestampKey);
  }
}
