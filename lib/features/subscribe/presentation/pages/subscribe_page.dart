import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/core/components/input_widget.dart';
import 'package:inetagan/core/config/app_validator.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/package_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';
import 'package:inetagan/routes/app_router.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
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
      ),
    );
  }

  buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            InputWidget(
              label: 'Nama Lengkap',
              controller: edtFullName,
              hintText: 'tulis nama lengkap anda',
              icon: Assets.icons.userRound,
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: AppValidator.validateName,
            ),
            Gap(12),
            InputWidget(
              label: 'Nomor KTP',
              controller: edtNik,
              hintText: 'nomor induk kependudukan',
              icon: Assets.icons.card,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              validator: AppValidator.validateNik,
            ),
            Gap(12),
            InputWidget(
              label: 'WhatsApp',
              controller: edtPhone,
              hintText: 'tulis nomor WhatsApp anda',
              icon: Assets.icons.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              validator: AppValidator.validatePhone,
            ),
            Gap(12),
            InputWidget(
              label: 'Alamat',
              controller: edtAddress,
              hintText: 'tulis Alamat lengkap anda',
              icon: Assets.icons.location,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              validator: AppValidator.validateAddress,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
              child: Text(
                'Contoh:\n Jl. Merdeka No. 123, RT 01/RW 02, Kelurahan Sukajadi, \nKecamatan Sukajadi, Kota Bandung, Jawa Barat',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Gap(30),
            ButtonWidget(
              ontap: () {
                if (!formKey.currentState!.validate()) return;
                DetailSubscribeRoute(
                  name: edtFullName.text,
                  nik: edtNik.text,
                  phone: edtPhone.text,
                  address: edtAddress.text,
                  $extra: widget.internetPackage,
                );
              },
              text: 'Berlangganan',
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
