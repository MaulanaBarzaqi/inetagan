import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../cubit/log_out/log_out_cubit.dart';
import 'profile_info_card.dart';
import 'profile_menu_item.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Padding diatur untuk konten di bawah AppBar
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        // Gap awal setelah AppBar
        const Gap(24),

        // Profile Card Container
        Container(
          // Sesuaikan margin horizontal jika Padding ListView (24) terlalu kecil
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const ProfileInfoCard(), // Widget Profile Info
              const Gap(20),

              // Menu Items (menggunakan ProfileMenuItem)
              ProfileMenuItem(
                icon: Assets.icons.icEditProfile,
                label: 'Edit Profile',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Assets.icons.wifi,
                label: 'Pemasangan Saya',
                onTap: () => GetSubscribeRoute().go(context),
              ),
              ProfileMenuItem(
                icon: Assets.icons.lockKeyhole,
                label: 'Ganti Password',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Assets.icons.icLogout,
                label: 'Logout',
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Log out"),
        content: const Text("Are you sure want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      context.read<LogOutCubit>().logOut();
    }
  }
}
