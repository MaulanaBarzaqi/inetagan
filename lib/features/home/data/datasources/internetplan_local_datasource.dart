import 'dart:convert';

import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/features/home/data/models/internetplan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InternetplanLocalDatasource {
  Future<List<InternetplanModel>> getAll();
  Future<bool> cacheAll(List<InternetplanModel> list);
}

class InternetplanLocalDatasourceImpl implements InternetplanLocalDatasource {
  final SharedPreferences pref;

  InternetplanLocalDatasourceImpl(this.pref);
  static const _cacheAllinternetPlanKey = 'all_internetplan';

  @override
  Future<List<InternetplanModel>> getAll() async {
    String? allInternetplan = pref.getString(_cacheAllinternetPlanKey);
    if (allInternetplan != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(
        jsonDecode(allInternetplan),
      );
      List<InternetplanModel> list = listMap
          .map((e) => InternetplanModel.fromJson(e))
          .toList();
      return list;
    }
    throw ServerException('something went wrong');
  }

  @override
  Future<bool> cacheAll(List<InternetplanModel> list) async {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allInternetPlan = jsonEncode(listMap);
    return pref.setString(_cacheAllinternetPlanKey, allInternetPlan);
  }
}
