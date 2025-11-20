import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_format.dart';
import '../../../../routes/app_router.dart';
import '../../domain/entities/notification_entity.dart';
import '../cubit/notifications_cubit.dart';

class NotificationListViewWidget extends StatelessWidget {
  final List<NotificationEntity> notifications;
  const NotificationListViewWidget({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notif = notifications[index];
        return NotificationListItem(notif: notif);
      },
    );
  }
}

class NotificationListItem extends StatelessWidget {
  final NotificationEntity notif;
  const NotificationListItem({super.key, required this.notif});

  void _showNotificationDetail(BuildContext context) {
    if (!notif.isRead) {
      context.read<NotificationsCubit>().markAsRead(notif.id);
    }
    showDialog(
      context: context,
      builder: (dialogContext) {
        return _NotificationDetailDialog(notif: notif);
      },
    );
  }

  void _deleteNotification(BuildContext context) {
    context.read<NotificationsCubit>().deleteNotification(notif.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notifikasi "${notif.title ?? "Pesan"}" dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isStatusUpdate =
        notif.dataPayload['type'] == 'installation_status_update';
    return Dismissible(
      key: ValueKey(notif.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red.shade600,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteNotification(context),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: _NotificationIcon(isStatusUpdate: isStatusUpdate),
            tileColor: notif.isRead
                ? Colors.transparent
                : AppColors.primary.withValues(alpha: 0.09),
            title: Text(
              notif.title ?? 'Pesan Baru',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              notif.body ?? 'tidak ada isi pesan',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.tertiary,
                fontWeight: notif.isRead ? FontWeight.normal : FontWeight.w600,
              ),
            ),
            trailing: Text(
              AppFormat.fullDate(notif.receivedAt),
              style: TextStyle(
                color: AppColors.tertiary,
                fontWeight: notif.isRead ? FontWeight.normal : FontWeight.w600,
              ),
            ),
            onTap: () => _showNotificationDetail(context),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            height: 1,
            thickness: 1,
            color: AppColors.tertiary.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  final bool isStatusUpdate;
  const _NotificationIcon({required this.isStatusUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.tertiary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Icon(
        isStatusUpdate ? Icons.wifi : Icons.notifications_on_outlined,
        color: AppColors.primary,
      ),
    );
  }
}

class _NotificationDetailDialog extends StatelessWidget {
  final NotificationEntity notif;
  const _NotificationDetailDialog({required this.notif});

  @override
  Widget build(BuildContext context) {
    final isStatusUpdate =
        notif.dataPayload['type'] == 'installation_status_update';
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: Row(
        children: [
          Icon(
            Icons.notifications_active_outlined,
            size: 28,
            color: AppColors.primary,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              notif.title ?? 'Detail Pemberitahuan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              notif.body ?? 'Tidak ada deskripsi detail.',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColors.tertiary.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
            const Gap(20),
            Text(
              'Diterima: ${AppFormat.fullDate(notif.receivedAt)}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(12),
      actions: <Widget>[
        if (isStatusUpdate)
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              'Lihat',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            onPressed: () {
              context.pop();
              GetSubscribeRoute().push(context);
            },
          ),
        TextButton(
          child: Text(
            'Tutup',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.tertiary.withValues(alpha: 0.8),
            ),
          ),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
