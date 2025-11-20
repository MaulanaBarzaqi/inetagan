import 'package:inetagan/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications();
  Future<void> saveNotification(NotificationEntity newNotification);
  Future<void> deleteNotification(String id);
  Future<void> markAsRead(String id);
}
