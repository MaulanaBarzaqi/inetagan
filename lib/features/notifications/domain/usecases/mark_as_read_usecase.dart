import 'package:inetagan/features/features.dart';

class MarkAsReadUsecase {
  final NotificationRepository _repository;

  MarkAsReadUsecase(this._repository);

  Future<void> call(String id) async {
    return await _repository.markAsRead(id);
  }
}
