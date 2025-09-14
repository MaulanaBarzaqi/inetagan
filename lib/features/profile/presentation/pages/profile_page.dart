import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/profile/presentation/cubit/log_out/log_out_cubit.dart';
import 'package:inetagan/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:inetagan/gen/assets.gen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;

    Future.delayed(Duration.zero, () {
      if (_isMounted) {
        context.read<ProfileCubit>().getProfile();
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogOutCubit, LogOutState>(
          listener: (context, state) {
            if (state is LogOutSuccess && _isMounted) {
              context.goNamed(RouteNames.signin);
            }
          },
        ),
      ],
      child: Stack(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
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
                        buildProfile(state),
                        Gap(20),
                        buildItemProfile(
                          icon: Assets.icons.icEditProfile,
                          label: 'Edit Profile',
                          ontap: () {},
                        ),
                        buildItemProfile(
                          icon: Assets.icons.wifi,
                          label: 'Pemasangan Saya',
                          ontap: () {
                            context.goNamed(RouteNames.getSubscribe);
                          },
                        ),
                        buildItemProfile(
                          icon: Assets.icons.lockKeyhole,
                          label: 'Ganti Password',
                          ontap: () {},
                        ),
                        buildItemProfile(
                          icon: Assets.icons.icLogout,
                          label: 'Logout',
                          ontap: () async {
                            final shouldLogout = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Log out"),
                                content: Text("are you sure want to logout?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text("cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text("logout"),
                                  ),
                                ],
                              ),
                            );
                            if (shouldLogout == true && _isMounted) {
                              context.read<LogOutCubit>().logOut();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          BlocBuilder<LogOutCubit, LogOutState>(
            builder: (context, state) {
              if (state is LogOutLoading && _isMounted) {
                return Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading && _isMounted) {
                return Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfile(ProfileState state) {
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
              if (state is ProfileLoading)
                SizedBox(
                  width: 120,
                  height: 16,
                  child: LinearProgressIndicator(),
                )
              else if (state is ProfileLoaded)
                Text(
                  state.profile.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                )
              else if (state is ProfileError)
                Text(
                  'error loading name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                )
              else
                Text(
                  'User name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),

              Gap(4),

              if (state is ProfileLoading)
                SizedBox(
                  width: 120,
                  height: 16,
                  child: LinearProgressIndicator(),
                )
              else if (state is ProfileLoaded)
                Text(
                  state.profile.email,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.tertiary,
                  ),
                )
              else if (state is ProfileError)
                Text(
                  'Error loading email',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.red,
                  ),
                )
              else
                Text(
                  'user@email.com',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.tertiary,
                  ),
                ),
            ],
          ),
          Spacer(),
          if (state is ProfileError || state is ProfileEmpty)
            IconButton(
              icon: Icon(Icons.refresh, color: AppColors.primary),
              onPressed: () {
                if (_isMounted) {
                  context.read<ProfileCubit>().getProfile();
                }
              },
            ),
        ],
      ),
    );
  }

  buildItemProfile({
    required SvgGenImage icon,
    required String label,
    required VoidCallback ontap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: ontap,
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
      ),
    );
  }
}
