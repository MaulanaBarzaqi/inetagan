import 'dart:convert';

import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/features/internet-package/data/models/internet_package_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InternetPackageLocalDatasource {
  Future<List<InternetPackageModel>> getAll();
  Future<bool> cacheAll(List<InternetPackageModel> list);
}

class InternetPackageLocalDatasourceImpl
    implements InternetPackageLocalDatasource {
  final SharedPreferences pref;

  InternetPackageLocalDatasourceImpl(this.pref);
  static const _cacheAllinternetPackageKey = 'all_internetPackage';

  @override
  Future<List<InternetPackageModel>> getAll() async {
    String? allInternetPackage = pref.getString(_cacheAllinternetPackageKey);
    if (allInternetPackage != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(
        jsonDecode(allInternetPackage),
      );
      List<InternetPackageModel> list = listMap
          .map((e) => InternetPackageModel.fromJson(e))
          .toList();
      return list;
    }
    throw CachedException('Failed to read from cache');
  }

  @override
  Future<bool> cacheAll(List<InternetPackageModel> list) async {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allInternetPackage = jsonEncode(listMap);
    return pref.setString(_cacheAllinternetPackageKey, allInternetPackage);
  }
}
