import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../gen/assets.gen.dart';
import '../cubit/profile/profile_cubit.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildAvatar(),
              const Gap(10),
              Expanded(child: _buildInfo(state)),
              _buildRefreshButton(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary),
      ),
      padding: const EdgeInsets.all(2),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.transparent,
        child: Assets.icons.circleUser.svg(height: 50, width: 50),
      ),
    );
  }

  Widget _buildInfo(ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        if (state is ProfileLoaded)
          Text(
            state.profile.name,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.primary,
            ),
          )
        else if (state is ProfileLoading)
          _buildLoadingPlaceholder()
        else
          Text(
            state is ProfileError ? 'Error loading name' : 'User name',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: state is ProfileError ? Colors.red : AppColors.primary,
            ),
          ),

        const Gap(4),

        // Email
        if (state is ProfileLoaded)
          Text(
            state.profile.email,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.tertiary,
            ),
          )
        else if (state is ProfileLoading)
          _buildLoadingPlaceholder()
        else
          Text(
            state is ProfileError ? 'Error loading email' : 'user@email.com',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: state is ProfileError ? Colors.red : AppColors.tertiary,
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingPlaceholder() {
    return const SizedBox(
      width: 120,
      height: 16,
      child: LinearProgressIndicator(),
    );
  }

  Widget _buildRefreshButton(BuildContext context, ProfileState state) {
    if (state is ProfileError || state is ProfileEmpty) {
      return IconButton(
        icon: Icon(Icons.refresh, color: AppColors.primary),
        onPressed: () => context.read<ProfileCubit>().getProfile(),
      );
    }
    return const SizedBox.shrink();
  }
}
