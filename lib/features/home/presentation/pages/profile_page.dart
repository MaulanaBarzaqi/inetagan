import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_session.dart';
import 'package:inetagan/features/signin/data/models/sign_in_model.dart';
import 'package:inetagan/gen/assets.gen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SignInModel? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await AppSession.getUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        Gap(30 + MediaQuery.of(context).padding.top),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'My Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AppColors.primary,
            ),
          ),
        ),
        Gap(41),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              buildProfile(),
              Gap(20),
              buildItemProfile(Assets.icons.icEditProfile, 'Edit Profile'),
              buildItemProfile(Assets.icons.lockKeyhole, 'Ganti Password'),
              buildItemProfile(Assets.icons.icLogout, 'Logout'),
            ],
          ),
        ),
      ],
    );
  }

  buildProfile() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
              child: Assets.icons.circleUser.svg(height: 50, width: 50),
            ),
          ),
          Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser?.name ?? 'Loading...',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
              Text(
                currentUser?.email ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildItemProfile(SvgGenImage icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 52,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Row(
          children: [
            icon.svg(width: 24, height: 24),
            Gap(14),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.secondary,
              ),
            ),
            Spacer(),
            Assets.icons.chevronRight.svg(height: 24, width: 24),
          ],
        ),
      ),
    );
  }
}
