import 'dart:convert';

import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/features/home/data/models/banner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BannerLocalDatasource {
  Future<List<BannerModel>> getAll();
  Future<bool> cacheAll(List<BannerModel> list);
}

class BannerLocalDatasourceImpl implements BannerLocalDatasource {
  final SharedPreferences pref;

  BannerLocalDatasourceImpl(this.pref);
  static const _cacheAllBannerKey = 'all_banner';

  @override
  Future<List<BannerModel>> getAll() async {
    String? allBanner = pref.getString(_cacheAllBannerKey);
    if (allBanner != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(
        jsonDecode(allBanner),
      );
      List<BannerModel> list = listMap
          .map((e) => BannerModel.fromJson(e))
          .toList();
      return list;
    }
    throw CachedException('Failed to read from cache');
  }

  @override
  Future<bool> cacheAll(List<BannerModel> list) async {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allBanner = jsonEncode(listMap);
    return pref.setString(_cacheAllBannerKey, allBanner);
  }
}
