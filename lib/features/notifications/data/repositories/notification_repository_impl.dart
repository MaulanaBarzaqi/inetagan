import 'package:inetagan/features/notifications/domain/entities/notification_entity.dart';
import 'package:inetagan/features/notifications/domain/repositories/notification_repository.dart';
import '../datasources/notification_local_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDatasource localDatasource;

  NotificationRepositoryImpl(this.localDatasource);

  @override
  Future<void> deleteNotification(String id) async {
    await localDatasource.deleteNotification(id);
  }

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final models = await localDatasource.getNotifications();
    return models;
  }

  @override
  Future<void> saveNotification(NotificationEntity newNotification) async {
    final newNotificationModel = NotificationModel(
      id: newNotification.id,
      title: newNotification.title,
      body: newNotification.body,
      dataPayload: newNotification.dataPayload,
      receivedAt: newNotification.receivedAt,
      isRead: newNotification.isRead,
    );

    await localDatasource.saveNotification(newNotificationModel);
  }

  @override
  Future<void> markAsRead(String id) async {
    await localDatasource.markAsRead(id);
  }
}
