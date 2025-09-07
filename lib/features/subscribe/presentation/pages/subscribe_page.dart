import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/core/components/input_widget.dart';
import 'package:inetagan/features/home/presentation/widgets/circle_loading_widget.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/gen/assets.gen.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key, required this.internetPackage});
  final InternetPackageEntity internetPackage;

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final edtFullName = TextEditingController();
  final edtPhone = TextEditingController();
  final edtNik = TextEditingController();
  final edtAddress = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    edtFullName.dispose();
    edtPhone.dispose();
    edtNik.dispose();
    edtAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Gap(20),
          buildPackage(),
          Gap(20),
          buildForm(),
          Gap(20),
        ],
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
            'Berlangganan Internet',
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
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ExtendedImage.network(
                AppConstant.imagePackage(widget.internetPackage.image),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                handleLoadingProgress: true,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    );
                  }
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return const CircleLoadingWidget();
                  }
                  return null;
                },
              ),
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

  buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 27, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Silahkan isi data diri anda',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(10),
                  InputWidget(
                    controller: edtFullName,
                    hintText: 'tulis nama lengkap anda',
                    keyboardType: TextInputType.name,
                    icon: Assets.icons.userRound,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (value.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  Text(
                    'Nomor NIK',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(10),
                  InputWidget(
                    controller: edtNik,
                    hintText: 'tulis nomor NIK anda',
                    keyboardType: TextInputType.name,
                    icon: Assets.icons.card,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (value.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  Text(
                    'WhatsApp',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(10),
                  InputWidget(
                    controller: edtPhone,
                    hintText: 'tulis nomor whatsapp anda',
                    keyboardType: TextInputType.name,
                    icon: Assets.icons.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (value.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  Text(
                    'Alamat Lengkap',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(10),
                  InputWidget(
                    controller: edtAddress,
                    hintText: 'tulis alamat lengkap anda',
                    keyboardType: TextInputType.name,
                    icon: Assets.icons.location,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (value.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ButtonWidget(
                ontap: () {
                  if (!formKey.currentState!.validate()) return;
                  context.pushNamed(
                    RouteNames.detailSubscribe,
                    extra: {
                      'internetPackage': widget.internetPackage,
                      'name': edtFullName.text,
                      'nik': edtNik.text,
                      'phone': edtPhone.text,
                      'address': edtAddress.text,
                    },
                  );
                },
                text: 'Ajukan Berlangganan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
