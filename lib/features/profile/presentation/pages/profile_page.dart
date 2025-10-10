import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/core/config/app_colors.dart';

import '../../../../routes/app_router.dart';
import '../cubit/log_out/log_out_cubit.dart';
import '../cubit/profile/profile_cubit.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/profile_content.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogOutCubit, LogOutState>(
          listener: (context, state) {
            if (state is LogOutSuccess) {
              // Navigasi setelah logout berhasil
              SignInRoute().go(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AppColors.primary,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          titleSpacing: 24.0,
        ),
        body: Stack(
          children: [
            ProfileContent(),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, profileState) {
                return BlocBuilder<LogOutCubit, LogOutState>(
                  builder: (context, logoutState) {
                    final isLoading =
                        profileState is ProfileLoading ||
                        logoutState is LogOutLoading;
                    if (isLoading) {
                      return const LoadingOverlay();
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
