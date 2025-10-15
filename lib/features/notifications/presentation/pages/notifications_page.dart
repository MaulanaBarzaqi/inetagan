import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/routes/app_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/app_colors.dart';
import '../cubit/notifications_cubit.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationsCubit>().loadNotifications();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.primary),
        title: Text(
          'Pemberitahuan',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationsFailed) {
            return const Center(
              child: Text('Gagal memuat riwayat notifikasi.'),
            );
          }

          if (state is NotificationsLoaded) {
            final notifications = state.notifications;
            if (notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_none,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Kotak Masuk Anda Kosong',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
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
                  onDismissed: (direction) {
                    // Panggil Cubit untuk menghapus dari SharedPreferences
                    context.read<NotificationsCubit>().deleteNotification(
                      notif.id,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Notifikasi "${notif.title ?? "Pesan"}" dihapus',
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      // Icon berdasarkan tipe notifikasi
                      isStatusUpdate ? Icons.wifi : Icons.notifications_none,
                      color: isStatusUpdate
                          ? AppColors.tertiary
                          : AppColors.primary,
                    ),
                    title: Text(
                      notif.title ?? 'Pesan Baru',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: isStatusUpdate
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      notif.body ?? 'Tidak ada deskripsi.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      // Format waktu
                      DateFormat('dd MMM kk:mm').format(notif.receivedAt),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    onTap: () {
                      if (isStatusUpdate) {
                        // Navigasi ke halaman khusus status pemasangan
                        GetSubscribeRoute().push(context);
                      } else {
                        // Logika tambahan untuk notifikasi umum, misalnya buka dialog detail
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Detail notifikasi umum.'),
                          ),
                        );
                      }
                      // Implementasi fitur 'mark as read' bisa ditambahkan di sini
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
