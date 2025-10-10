import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/components/input_widget.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_validator.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../../../internet-package/domain/entities/internet_package_entity.dart';
import '../../../internet-package/presentation/widgets/package_list/package_image_widget.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key, required this.internetPackage});
  final InternetPackageEntity internetPackage;

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  late final TextEditingController edtFullName;
  late final TextEditingController edtPhone;
  late final TextEditingController edtNik;
  late final TextEditingController edtAddress;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    edtFullName = TextEditingController();
    edtPhone = TextEditingController();
    edtNik = TextEditingController();
    edtAddress = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    edtFullName.dispose();
    edtPhone.dispose();
    edtNik.dispose();
    edtAddress.dispose();
    super.dispose();
  }

  void _navigateToDetailSubscribe() {
    if (!formKey.currentState!.validate()) return;
    DetailSubscribeRoute(
      name: edtFullName.text,
      nik: edtNik.text,
      phone: edtPhone.text,
      address: edtAddress.text,
      $extra: widget.internetPackage,
    ).push(context);
  }

  Widget _buildSelectedPackage() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.primary),
        title: Text(
          'Berlangganan Internet',
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
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Gap(20),
          _buildSelectedPackage(),
          Gap(20),
          _buildSubcriptionForm(),
          Gap(20),
        ],
      ),
    );
  }

  Widget _buildSubcriptionForm() {
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
            const Gap(12),
            InputWidget(
              label: 'Nomor KTP',
              controller: edtNik,
              hintText: 'nomor induk kependudukan',
              icon: Assets.icons.card,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              validator: AppValidator.validateNik,
            ),
            const Gap(12),
            InputWidget(
              label: 'WhatsApp',
              controller: edtPhone,
              hintText: 'tulis nomor WhatsApp anda',
              icon: Assets.icons.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              validator: AppValidator.validatePhone,
            ),
            const Gap(12),
            InputWidget(
              label: 'Alamat',
              controller: edtAddress,
              hintText: 'tulis Alamat lengkap anda',
              icon: Assets.icons.location,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              validator: AppValidator.validateAddress,
            ),
            const _AddressInfoText(),
            Gap(30),
            ButtonWidget(
              ontap: _navigateToDetailSubscribe,
              text: 'Berlangganan',
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}

class _AddressInfoText extends StatelessWidget {
  const _AddressInfoText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
      child: Text(
        'Contoh:\n Jl. Merdeka No. 123, RT 01/RW 02, Kelurahan Sukajadi, \nKecamatan Sukajadi, Kota Bandung, Jawa Barat',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
