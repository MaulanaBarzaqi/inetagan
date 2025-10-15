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
  // Di sini Anda perlu memastikan Entity diubah menjadi Model
  // Namun, karena yang ingin disimpan ke SharedPreferences adalah NotificationModel
  // (yang memiliki method .toJson()), Anda perlu mengubah Entity menjadi Model
  // sebelum disimpan ke Datasource, atau membuat method .toJson() di Entity
  // dan Datasource menerima Entity. Untuk konsistensi, kita akan ubah Entity menjadi Model.
  // Jika NotificationEntity tidak memiliki factory/constructor untuk membuat NotificationModel,
  // kita asumsikan NotificationModel dapat dibuat dari Entity.

  // CATATAN: Karena NotificationModel extends NotificationEntity,
  // kita bisa buat constructor di NotificationModel yang menerima NotificationEntity.
  // Atau kita buat objek NotificationModel baru dari property Entity.
}
