import 'package:inetagan/features/notifications/domain/entities/notification_entity.dart';
import 'package:inetagan/features/notifications/domain/repositories/notification_repository.dart';

class SaveNotificationUsecase {
  final NotificationRepository _repository;

  SaveNotificationUsecase(this._repository);

  Future<void> call(NotificationEntity newNotification) async {
    return await _repository.saveNotification(newNotification);
  }
}
