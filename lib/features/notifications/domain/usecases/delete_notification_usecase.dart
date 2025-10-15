import 'package:inetagan/features/notifications/domain/repositories/notification_repository.dart';

class DeleteNotificationUsecase {
  final NotificationRepository _repository;

  DeleteNotificationUsecase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteNotification(id);
  }
}
