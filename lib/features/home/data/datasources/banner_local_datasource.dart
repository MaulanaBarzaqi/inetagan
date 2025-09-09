import 'dart:convert';

import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/features/home/data/models/banner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BannerLocalDatasource {
  Future<List<BannerModel>> getCachedBanners();
  Future<void> cacheBanners(List<BannerModel> banners);
  Future<void> clearBannersCache();
  Future<bool> hasCachedBanners();
}

class BannerLocalDatasourceImpl implements BannerLocalDatasource {
  final SharedPreferences pref;

  BannerLocalDatasourceImpl(this.pref);

  static const _cacheBannersKey = 'cached_banners';
  static const _cacheTimestampKey = 'banner_cache_timestamp';
  static const Duration cacheDuration = Duration(hours: 1);

  @override
  Future<List<BannerModel>> getCachedBanners() async {
    try {
      final cachedData = pref.getString(_cacheBannersKey);
      final cachedTime = pref.getInt(_cacheTimestampKey);

      if (cachedData == null || cachedTime == null) {
        throw CachedException('no cached banners found');
      }
      final cacheDateTime = DateTime.fromMicrosecondsSinceEpoch(cachedTime);
      if (DateTime.now().difference(cacheDateTime) > cacheDuration) {
        await clearBannersCache();
        throw CachedException('Cache expired');
      }
      final List<dynamic> jsonList = jsonDecode(cachedData);
      return jsonList.map((json) => BannerModel.fromJson(json)).toList();
    } catch (e) {
      throw CachedException('Failed to read from cache: $e');
    }
  }

  @override
  Future<void> cacheBanners(List<BannerModel> banners) async {
    try {
      final jsonList = banners.map((banner) => banner.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await pref.setString(_cacheBannersKey, jsonString);
      await pref.setInt(
        _cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      throw CachedException('Failed to cache banners: $e');
    }
  }

  @override
  Future<void> clearBannersCache() async {
    await pref.remove(_cacheBannersKey);
    await pref.remove(_cacheTimestampKey);
  }

  @override
  Future<bool> hasCachedBanners() async {
    return pref.containsKey(_cacheBannersKey) &&
        pref.containsKey(_cacheTimestampKey);
  }
}
