import 'package:d_method/d_method.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/notifications/domain/entities/notification_entity.dart';
import 'package:inetagan/features/notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:inetagan/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:inetagan/features/notifications/domain/usecases/mark_as_read_usecase.dart';
import 'package:inetagan/features/notifications/domain/usecases/save_notification_usecase.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUsecase getNotifications;
  final SaveNotificationUsecase saveNotification;
  final DeleteNotificationUsecase deleteNottification;
  final MarkAsReadUsecase readNotification;
  NotificationsCubit({
    required this.getNotifications,
    required this.saveNotification,
    required this.deleteNottification,
    required this.readNotification,
  }) : super(NotificationsInitial());

  Future<void> loadNotifications() async {
    emit(NotificationsLoading());
    try {
      final notifications = await getNotifications.call();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsFailed(e.toString()));
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await readNotification.call(id);
      await loadNotifications();
    } catch (e) {
      DMethod.log('Failed to mark notification $id as read: $e');
    }
  }

  Future<void> deleteNotification(String id) async {
    await deleteNottification.call(id);
    await loadNotifications();
  }

  Future<void> saveAndReload(NotificationEntity notification) async {
    await saveNotification.call(notification);
    if (state is NotificationsLoaded) {
      await loadNotifications();
    }
  }
}
