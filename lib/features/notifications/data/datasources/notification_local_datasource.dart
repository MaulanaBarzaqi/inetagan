import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';

abstract class NotificationLocalDatasource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> saveNotification(NotificationModel newNotification);
  Future<void> deleteNotification(String id);
  Future<void> markAsRead(String id);
}

class NotificationLocalDatasourceImpl implements NotificationLocalDatasource {
  final SharedPreferences pref;

  NotificationLocalDatasourceImpl(this.pref);

  static const _keyNotifications = 'notification_history_list';

  // Mengambil List<NotificationModel> dari JSON String
  @override
  Future<List<NotificationModel>> getNotifications() async {
    final jsonString = pref.getString(_keyNotifications);
    if (jsonString == null || jsonString.isEmpty) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // menyimpan notifikasi baru
  @override
  Future<void> saveNotification(NotificationModel newNotification) async {
    final currentList = await getNotifications();
    currentList.insert(0, newNotification);

    final List<Map<String, dynamic>> jsonList = currentList
        .map((n) => n.toJson())
        .toList();

    await pref.setString(_keyNotifications, jsonEncode(jsonList));
  }

  // delete notification
  @override
  Future<void> deleteNotification(String id) async {
    final currentList = await getNotifications();
    currentList.removeWhere((notif) => notif.id == id);

    final List<Map<String, dynamic>> jsonList = currentList
        .map((n) => n.toJson())
        .toList();

    await pref.setString(_keyNotifications, jsonEncode(jsonList));
  }

  @override
  Future<void> markAsRead(String id) async {
    final currentList = await getNotifications();
    final index = currentList.indexWhere((notif) => notif.id == id);

    if (index != -1 && !currentList[index].isRead) {
      final updatedNotif = currentList[index].copyWith(isRead: true);
      currentList[index] = updatedNotif;

      final List<Map<String, dynamic>> jsonList = currentList
          .map((n) => n.toJson())
          .toList();

      await pref.setString(_keyNotifications, jsonEncode(jsonList));
    }
  }
}
