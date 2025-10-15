import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/notifications/domain/entities/notification_entity.dart';
import 'package:inetagan/features/notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:inetagan/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:inetagan/features/notifications/domain/usecases/save_notification_usecase.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUsecase getNotifications;
  final SaveNotificationUsecase saveNotification;
  final DeleteNotificationUsecase deleteNottification;
  NotificationsCubit({
    required this.getNotifications,
    required this.saveNotification,
    required this.deleteNottification,
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
