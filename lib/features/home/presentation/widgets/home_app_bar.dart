import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:inetagan/routes/app_router.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../profile/presentation/cubit/profile/profile_cubit.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      forceMaterialTransparency: true,
      title: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          String userName = 'Hi, User!';
          if (state is ProfileLoaded) {
            userName = 'Hi, ${state.profile.name}';
          }
          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary),
                ),
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.transparent,
                  child: Assets.icons.circleUser.svg(height: 24, width: 24),
                ),
              ),
              Gap(8),
              Flexible(
                child: Text(
                  userName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: AppColors.tertiary,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              NotificationRoute().push(context);
            },
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                bool hasUnread = false;
                if (state is NotificationsLoaded) {
                  hasUnread = state.notifications.any((n) => !n.isRead);
                }
                return Stack(
                  children: [
                    Icon(
                      Icons.notifications_none,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    if (hasUnread)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
