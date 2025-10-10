import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/features/subscribe/presentation/widgets/status_extension.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_format.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../../../internet-package/presentation/widgets/package_list/package_image_widget.dart';
import '../../../profile/presentation/cubit/profile/profile_cubit.dart';
import '../bloc/get_subscription/get_subscription_bloc.dart';
import '../widgets/build_info_row_widget.dart';

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

  Future<void> _refreshData() async {
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.primary),
        title: Text(
          'Pemasangan Saya',
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
      body: RefreshIndicator.adaptive(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Gap(20),
              _SubscriptionContent(),
              const Gap(20),
              ButtonWidget(
                ontap: () => ProfileRoute().go(context),
                text: 'Kembali',
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscriptionContent extends StatelessWidget {
  const _SubscriptionContent();

  void _loadSubscription(BuildContext context, int userId) {
    context.read<GetSubscriptionBloc>().add(OnGetSubscriptionEvent(userId));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, profileState) {
          if (profileState is ProfileLoaded) {
            _loadSubscription(context, profileState.profile.id);
          }
        },
        builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (profileState is ProfileError) {
            return _ProfileErrorState(
              message: profileState.message,
              onRetry: () => context.read<ProfileCubit>().getProfile(),
            );
          }
          if (profileState is ProfileEmpty) {
            return const _ProfileEmptyState();
          }
          if (profileState is ProfileLoaded) {
            return BlocBuilder<GetSubscriptionBloc, GetSubscriptionState>(
              builder: (context, getState) {
                if (getState is GetSubscriptionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (getState is GetSubscriptionFailed) {
                  return _SubscriptionErrorState(
                    message: getState.message,
                    onRetry: () =>
                        _loadSubscription(context, profileState.profile.id),
                  );
                }
                if (getState is GetSubscriptionSuccess) {
                  return _SubscriptionSuccessContent(
                    subscription: getState.data,
                  );
                }
                return const Text(
                  'Memuat data langganan...',
                  textAlign: TextAlign.center,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _SubscriptionSuccessContent extends StatelessWidget {
  final dynamic subscription;
  const _SubscriptionSuccessContent({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final package = subscription.internetPackage;
    final user = subscription.user;
    if (package == null) {
      return const Column(
        children: [
          Icon(Icons.error_outline, size: 40, color: Colors.grey),
          Text(
            'Data paket tidak tersedia!',
            style: TextStyle(color: AppColors.tertiary),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    final price = package.monthlyBill + package.installation;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PackageImageWidget(package: package, width: 100, height: 100),
            const Gap(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    package.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(5),
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
            ),
          ],
        ),
        Divider(thickness: 2, color: AppColors.primary),
        BuildInfoRowWidget(
          label: 'Nama',
          value: subscription.name,
          icon: Assets.icons.userRound,
        ),
        BuildInfoRowWidget(
          label: 'Email',
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
        _StatusRow(status: subscription.status ?? 'pending'),
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
        const Divider(),
        _TotalCostCard(price: price),
        const Gap(2),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
          child: Text(
            'info:\nLokasi akan disurvei 2 hari setelah status di approved.',
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
}

class _TotalCostCard extends StatelessWidget {
  final int price;
  const _TotalCostCard({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
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
          Text(
            AppFormat.longPrice(price),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String status;
  const _StatusRow({required this.status});

  @override
  Widget build(BuildContext context) {
    final statusColor = status.getStatusColor();
    return Row(
      children: [
        status.getStatusIcon(),
        const Gap(12),
        Expanded(
          child: Text(
            'Status',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: statusColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            status,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ProfileErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Error Profil: $message',
          style: TextStyle(color: Colors.red[400]),
          textAlign: TextAlign.center,
        ),
        const Gap(10),
        Text(
          'Coba Lagi Profil',
          style: TextStyle(color: AppColors.tertiary),
          textAlign: TextAlign.center,
        ),
        IconButton(
          onPressed: onRetry,
          icon: Icon(Icons.replay_rounded, color: AppColors.tertiary),
        ),
      ],
    );
  }
}

class _ProfileEmptyState extends StatelessWidget {
  const _ProfileEmptyState();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Data pengguna tidak ditemukan. Silakan masuk lagi!',
      textAlign: TextAlign.center,
    );
  }
}

class _SubscriptionErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _SubscriptionErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Error Langganan: $message',
          style: TextStyle(color: Colors.red[400]),
          textAlign: TextAlign.center,
        ),
        const Gap(10),
        Text(
          'Coba Lagi Langganan',
          style: TextStyle(color: AppColors.tertiary),
          textAlign: TextAlign.center,
        ),
        IconButton(
          onPressed: onRetry,
          icon: Icon(Icons.replay_rounded, color: AppColors.tertiary),
        ),
      ],
    );
  }
}
