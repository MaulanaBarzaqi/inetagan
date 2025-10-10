import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
            mainAxisSize: MainAxisSize.min,
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
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.tertiary,
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 30.0),
          child: Icon(Icons.notifications_none, color: AppColors.primary),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
