import 'package:inetagan/features/notifications/domain/entities/notification_entity.dart';
import 'package:inetagan/features/notifications/domain/repositories/notification_repository.dart';

class GetNotificationsUsecase {
  final NotificationRepository _repository;

  GetNotificationsUsecase(this._repository);

  Future<List<NotificationEntity>> call() async {
    return await _repository.getNotifications();
  }
}
