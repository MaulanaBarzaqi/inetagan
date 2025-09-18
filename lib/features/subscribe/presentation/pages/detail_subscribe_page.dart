import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/core/components/loading_widget.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/package_image_widget.dart';
import 'package:inetagan/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:inetagan/features/subscribe/presentation/bloc/subscribe/subscribe_bloc.dart';
import 'package:inetagan/features/subscribe/presentation/widgets/detail_item_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SubscribeBloc, SubscribeState>(
        listener: (context, subscribeState) {
          if (subscribeState is SubscribeSuccess) {
            context.goNamed(RouteNames.success);
          }
          if (subscribeState is SubscribeFailed) {
            if (subscribeState.message.contains('sudah memiliki')) {
              _showAlreadySubscribedDialog(context);
            } else {
              context.goNamed(RouteNames.failed);
            }
          }
        },
        builder: (context, subscribeState) {
          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Gap(20 + MediaQuery.of(context).padding.top),
                  buildHeader(),
                  Gap(20),
                  buildPackage(),
                  Gap(20),
                  buildDetail(),
                  Gap(20),
                ],
              ),
              if (subscribeState is SubscribeLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
            'Detail Berlangganan',
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

  buildPackage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        child: Row(
          children: [
            PackageImageWidget(
              package: widget.internetPackage,
              width: 100,
              height: 100,
            ),
            const Gap(10),
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
      ),
    );
  }

  buildDetail() {
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
                  label: 'nama',
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
                          AppFormat.longPrice(total),
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
                Gap(5),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 16.0),
                  child: Text(
                    'info:\n Hanya bisa 1 kali dilalakukan oleh setiap user.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(30),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              if (profileState is ProfileLoading) {
                return LoadingWidget();
              }
              if (profileState is ProfileError) {
                return Column(
                  children: [
                    Text(
                      'Error: ${profileState.message}',
                      style: TextStyle(color: Colors.red),
                    ),
                    Gap(10),
                    IconButton(
                      onPressed: () =>
                          context.read<ProfileCubit>().getProfile(),
                      icon: Icon(
                        Icons.replay_rounded,
                        color: AppColors.tertiary,
                      ),
                    ),
                  ],
                );
              }
              if (profileState is ProfileEmpty) {
                return Text(
                  'User data not found',
                  style: TextStyle(color: Colors.red),
                );
              }

              if (profileState is ProfileLoaded) {
                final hasExistingSubscription =
                    profileState.profile.hasActiveInstallation;

                return ButtonWidget(
                  ontap: () {
                    if (hasExistingSubscription) {
                      _showAlreadySubscribedDialog(context);
                    } else {
                      context.read<SubscribeBloc>().add(
                        OnSubscribeEvent(
                          name: widget.name,
                          nik: widget.nik,
                          phone: widget.phone,
                          address: widget.address,
                          userId: profileState.profile.id,
                          internetPackageId: widget.internetPackage.id,
                        ),
                      );
                    }
                  },
                  text: 'Ajukan',
                );
              }
              return IconButton(
                onPressed: () => context.read<ProfileCubit>().getProfile(),
                icon: Icon(Icons.replay_rounded, color: AppColors.tertiary),
              );
            },
          ),
        ],
      ),
    );
  }
}
