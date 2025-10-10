import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/components/loading_widget.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_format.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../../../internet-package/domain/entities/internet_package_entity.dart';
import '../../../internet-package/presentation/widgets/package_list/package_image_widget.dart';
import '../../../profile/presentation/cubit/profile/profile_cubit.dart';
import '../bloc/subscribe/subscribe_bloc.dart';
import '../widgets/detail_item_widget.dart';

class DetailSubscribePage extends StatefulWidget {
  const DetailSubscribePage({
    super.key,
    required this.internetPackage,
    required this.name,
    required this.nik,
    required this.phone,
    required this.address,
  });
  final InternetPackageEntity internetPackage;
  final String name;
  final String nik;
  final String phone;
  final String address;

  @override
  State<DetailSubscribePage> createState() => _DetailSubscribePageState();
}

class _DetailSubscribePageState extends State<DetailSubscribePage> {
  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    super.initState();
  }

  void _showAlreadySubscribedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sudah Berlangganan'),
          content: Text(
            'Anda sudah memiliki langganan internet aktif.'
            'setiap user hanya dapat melakukan satu kali berlangganan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onSubscribePressed(
    BuildContext context,
    bool hasExistingSubscription,
    int? userId,
  ) {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Data pengguna belum tersedia.')),
      );
      return;
    }
    if (hasExistingSubscription) {
      _showAlreadySubscribedDialog(context);
    } else {
      context.read<SubscribeBloc>().add(
        OnSubscribeEvent(
          name: widget.name,
          nik: widget.nik,
          phone: widget.phone,
          address: widget.address,
          userId: userId,
          internetPackageId: widget.internetPackage.id,
        ),
      );
    }
  }

  Widget _buildSelectedPackage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          PackageImageWidget(
            package: widget.internetPackage,
            width: 100,
            height: 100,
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.internetPackage.name,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  widget.internetPackage.idealDevice,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.tertiary,
                  ),
                ),
                const Gap(10),
                Text(
                  widget.internetPackage.speed,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // page utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.primary),
        title: Text(
          'Detail Berlangganan',
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
      body: BlocConsumer<SubscribeBloc, SubscribeState>(
        listener: (context, subscribeState) {
          if (subscribeState is SubscribeSuccess) {
            SuccessSubscribeRoute().go(context);
          }
          if (subscribeState is SubscribeFailed) {
            if (subscribeState.message.contains('sudah memiliki')) {
              _showAlreadySubscribedDialog(context);
            } else {
              FailedSubscribeRoute().go(context);
            }
          }
        },
        builder: (context, subscribeState) {
          final isSubscribeLoading = subscribeState is SubscribeLoading;
          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.only(bottom: 20),
                children: [
                  const Gap(20),
                  _buildSelectedPackage(),
                  const Gap(20),
                  _buildDetailDataAndCost(),
                  Gap(20),
                  _buildActionButton(context, isSubscribeLoading),
                  Gap(20),
                ],
              ),
              if (isSubscribeLoading) const _LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, bool isSubscribeLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          int? userId;
          bool hasActiveSubscription = false;

          if (profileState is ProfileLoaded) {
            userId = profileState.profile.id;
            hasActiveSubscription = profileState.profile.hasActiveInstallation;
          }

          if (profileState is ProfileLoading) {
            return const LoadingWidget();
          }

          if (profileState is ProfileError) {
            return _ProfileErrorWidget(
              message: profileState.message,
              onRetry: () => context.read<ProfileCubit>().getProfile(),
            );
          }

          if (profileState is ProfileEmpty) {
            return const Text(
              'User data not found',
              style: TextStyle(color: Colors.red),
            );
          }

          return ButtonWidget(
            ontap: isSubscribeLoading
                ? null
                : () => _onSubscribePressed(
                    context,
                    hasActiveSubscription,
                    userId,
                  ),
            text: 'Ajukan',
          );
        },
      ),
    );
  }

  Widget _buildDetailDataAndCost() {
    final total =
        widget.internetPackage.monthlyBill +
        widget.internetPackage.installation;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                DetailItemWidget(
                  icon: Assets.icons.userRound,
                  label: 'Nama',
                  itemDetail: widget.name,
                ),
                DetailItemWidget(
                  icon: Assets.icons.card,
                  label: 'NIK',
                  itemDetail: widget.nik,
                ),
                DetailItemWidget(
                  icon: Assets.icons.phone,
                  label: 'WhatsApp',
                  itemDetail: widget.phone,
                ),
                DetailItemWidget(
                  icon: Assets.icons.location,
                  label: 'Alamat',
                  itemDetail: widget.address,
                ),
                DetailItemWidget(
                  icon: Assets.icons.usdCircle,
                  label: 'Biaya Bulanan',
                  itemDetail: widget.internetPackage.monthlyBill,
                ),
                DetailItemWidget(
                  icon: Assets.icons.bill,
                  label: 'Biaya Pemasangan',
                  itemDetail: widget.internetPackage.installation,
                ),
                Divider(),
                const Gap(10),
                _TotalCostCard(total: total),
                const Gap(5),
                const _SubscriptionInfoText(),
              ],
            ),
          ),
          const Gap(30),
        ],
      ),
    );
  }
}

class _TotalCostCard extends StatelessWidget {
  const _TotalCostCard({required this.total});
  final int total;

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
          const Expanded(
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
              AppFormat.longPrice(total),
              textAlign: TextAlign.right, // Penyesuaian agar lebih rapi
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionInfoText extends StatelessWidget {
  const _SubscriptionInfoText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, right: 16.0),
      child: Text(
        'Info:\n Hanya bisa 1 kali dilakukan oleh setiap user.',
        textAlign: TextAlign.right, // Penyesuaian agar lebih rapi
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ProfileErrorWidget extends StatelessWidget {
  const _ProfileErrorWidget({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Error: $message',
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
        const Gap(10),
        IconButton(
          onPressed: onRetry,
          icon: Icon(Icons.replay_rounded, color: AppColors.tertiary),
        ),
      ],
    );
  }
}
