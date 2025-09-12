import 'dart:convert';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/features/category/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoryLocalDatasource {
  Future<List<CategoryModel>> getCachedCategories();
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<void> clearCategoriesCache();
  Future<bool> hasCachedCategories();
}

class CategoryLocalDatasourceImpl implements CategoryLocalDatasource {
  final SharedPreferences prefs;

  CategoryLocalDatasourceImpl(this.prefs);

  static const _cacheCategoriesKey = 'cached_categories';
  static const _cacheTimestampKey = 'category_cache_timestamp';
  static const Duration cacheDuration = Duration(hours: 1);

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    try {
      final cachedData = prefs.getString(_cacheCategoriesKey);
      final cachedTime = prefs.getInt(_cacheTimestampKey);

      if (cachedData == null || cachedTime == null) {
        throw CachedException('No cached categories found');
      }

      final cacheDateTime = DateTime.fromMillisecondsSinceEpoch(cachedTime);
      if (DateTime.now().difference(cacheDateTime) > cacheDuration) {
        await clearCategoriesCache();
        throw CachedException('Cache expired');
      }

      final List<dynamic> jsonList = jsonDecode(cachedData);
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw CachedException('Failed to read from cache: $e');
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      final jsonList = categories.map((category) => category.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await prefs.setString(_cacheCategoriesKey, jsonString);
      await prefs.setInt(
        _cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      throw CachedException('Failed to cache categories: $e');
    }
  }

  @override
  Future<void> clearCategoriesCache() async {
    await prefs.remove(_cacheCategoriesKey);
    await prefs.remove(_cacheTimestampKey);
  }

  @override
  Future<bool> hasCachedCategories() async {
    return prefs.containsKey(_cacheCategoriesKey) &&
        prefs.containsKey(_cacheTimestampKey);
  }
}
