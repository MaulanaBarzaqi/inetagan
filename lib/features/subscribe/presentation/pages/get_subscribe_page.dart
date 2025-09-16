import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/package_widget.dart';
import 'package:inetagan/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:inetagan/features/subscribe/presentation/bloc/get_subscription/get_subscription_bloc.dart';
import 'package:inetagan/features/subscribe/presentation/widgets/build_info_row_widget.dart';
import 'package:inetagan/features/subscribe/presentation/widgets/status_extension.dart';
import 'package:inetagan/gen/assets.gen.dart';

class GetSubscribePage extends StatefulWidget {
  const GetSubscribePage({super.key});

  @override
  State<GetSubscribePage> createState() => _GetSubscribePageState();
}

class _GetSubscribePageState extends State<GetSubscribePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  Future<void> refresh() async {
    context.read<ProfileCubit>().getProfile();
  }

  void _loadSubscription(int userId) {
    context.read<GetSubscriptionBloc>().add(OnGetSubscriptionEvent(userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async => refresh(),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Gap(20 + MediaQuery.of(context).padding.top),
            buildHeader(),
            Gap(20),
            buildSubscription(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.goNamed(RouteNames.dashboard);
            },
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Assets.icons.arrowLeft.svg(height: 24, width: 24),
            ),
          ),
          Text(
            'Pemasangan Saya',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Assets.icons.ellipsisVertical.svg(height: 24, width: 24),
          ),
        ],
      ),
    );
  }

  Widget buildSubscription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildSubscriptionContent(),
          ),
          Gap(20),
          ButtonWidget(
            ontap: () => context.goNamed(RouteNames.dashboard),
            text: 'Kembali',
          ),
          Gap(20),
        ],
      ),
    );
  }

  Widget _buildSubscriptionContent() {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, prflState) {
        if (prflState is ProfileLoaded) {
          _loadSubscription(prflState.profile.id);
        }
      },
      builder: (context, prflState) {
        if (prflState is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (prflState is ProfileError) {
          return Column(
            children: [
              Text(
                'Error: ${prflState.message}',
                style: TextStyle(color: Colors.red[400]),
                textAlign: TextAlign.center,
              ),
              const Gap(10),
              Text(
                'Retry Profile',
                style: TextStyle(color: AppColors.tertiary),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () => context.read<ProfileCubit>().getProfile(),
                icon: Icon(Icons.replay_rounded, color: AppColors.tertiary),
              ),
            ],
          );
        }
        if (prflState is ProfileEmpty) {
          return Text(
            'User data not found. please login again!',
            textAlign: TextAlign.center,
          );
        }
        if (prflState is ProfileLoaded) {
          return BlocBuilder<GetSubscriptionBloc, GetSubscriptionState>(
            builder: (context, gsubState) {
              if (gsubState is GetSubscriptionLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (gsubState is GetSubscriptionFailed) {
                return Column(
                  children: [
                    Text(
                      'Error: ${gsubState.message}',
                      style: TextStyle(color: Colors.red[400]),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    Text(
                      'Retry subscription',
                      style: TextStyle(color: AppColors.tertiary),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () => _loadSubscription(prflState.profile.id),
                      icon: Icon(
                        Icons.replay_rounded,
                        color: AppColors.tertiary,
                      ),
                    ),
                  ],
                );
              }
              if (gsubState is GetSubscriptionSuccess) {
                final subscription = gsubState.data;
                final package = gsubState.data.internetPackage;
                final user = gsubState.data.user;
                if (package == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 40, color: Colors.grey),
                      Text(
                        'package data not avaible!',
                        style: TextStyle(color: AppColors.tertiary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
                final price = package.monthlyBill + package.installation;
                return Column(
                  children: [
                    Row(
                      children: [
                        PackageImageWidget(
                          package: package,
                          width: 100,
                          height: 100,
                        ),
                        Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            Gap(5),
                            Text(
                              package.idealDevice,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.tertiary,
                              ),
                            ),
                            Text(
                              package.speed,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(thickness: 2, color: AppColors.primary),
                    BuildInfoRowWidget(
                      label: 'nama',
                      value: subscription.name,
                      icon: Assets.icons.userRound,
                    ),
                    BuildInfoRowWidget(
                      label: 'email',
                      value: user?.email ?? 'tidak ada email',
                      icon: Assets.icons.mail,
                    ),
                    BuildInfoRowWidget(
                      label: 'NIK',
                      value: subscription.nik,
                      icon: Assets.icons.card,
                    ),
                    BuildInfoRowWidget(
                      label: 'WhatsApp',
                      value: subscription.phone,
                      icon: Assets.icons.phone,
                    ),
                    BuildInfoRowWidget(
                      label: 'Alamat',
                      value: subscription.address,
                      icon: Assets.icons.location,
                    ),
                    BuildInfoRowWidget(
                      label: 'Waktu Pengajuan',
                      value: AppFormat.shortDate(subscription.createdAt),
                      icon: Assets.icons.calendar,
                    ),
                    Row(
                      children: [
                        (subscription.status ?? 'pending').getStatusIcon(),
                        Gap(12),
                        Expanded(
                          child: Text(
                            'status',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (subscription.status ?? 'pending')
                                .getStatusColor()
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: (subscription.status ?? 'pending')
                                  .getStatusColor()
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            subscription.status ?? 'pending',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: (subscription.status ?? 'pending')
                                  .getStatusColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BuildInfoRowWidget(
                      label: 'Biaya Pemasangan',
                      value: AppFormat.longPrice(package.installation),
                      icon: Assets.icons.bill,
                    ),
                    BuildInfoRowWidget(
                      label: 'Biaya Bulanan',
                      value: AppFormat.longPrice(package.monthlyBill),
                      icon: Assets.icons.usdCircle,
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Total Biaya",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              AppFormat.longPrice(price),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(2),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Text(
                        'info:\n Lokasi akan disurvei 2 hari setelah status di approved.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Text(
                'Loading subscription data...',
                textAlign: TextAlign.center,
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
