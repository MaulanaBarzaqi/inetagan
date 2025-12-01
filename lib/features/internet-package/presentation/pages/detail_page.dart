import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_format.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_router.dart';
import '../../domain/entities/internet_package_entity.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.internetPackage});
  final InternetPackageEntity internetPackage;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.primary),
        title: Text(
          'Detail Paket Internet',
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
          Gap(30),
          DetailPackageCard(internetPackage: widget.internetPackage),
          Gap(10),
        ],
      ),
    );
  }
}

class DetailPackageCard extends StatelessWidget {
  final InternetPackageEntity internetPackage;
  const DetailPackageCard({super.key, required this.internetPackage});

  @override
  Widget build(BuildContext context) {
    final int total =
        internetPackage.monthlyBill + internetPackage.installation;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            internetPackage.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.primary,
            ),
          ),
          Gap(34),
          _DetailItemWidget(
            label: 'Untuk',
            detail: internetPackage.idealDevice,
          ),
          Gap(11),
          _DetailItemWidget(label: 'speed', detail: internetPackage.speed),
          Gap(11),
          _DetailItemWidget(
            label: 'kategori',
            detail: internetPackage.category?.name ?? 'tidak ada category',
          ),
          Gap(11),
          _DetailItemWidget(
            label: 'Pemasangan',
            detail: internetPackage.installation,
          ),
          Gap(11),
          _DetailItemWidget(
            label: 'Bulanan',
            detail: internetPackage.monthlyBill,
          ),
          Gap(50),
          _ButtonSubcribeWidget(
            onTap: () {
              SubscribeRoute($extra: internetPackage).push(context);
            },
            total: total,
          ),
        ],
      ),
    );
  }
}

class _DetailItemWidget extends StatelessWidget {
  final String label;
  final dynamic detail;
  const _DetailItemWidget({required this.label, required this.detail});

  @override
  Widget build(BuildContext context) {
    final String formattedDetail = detail is int
        ? AppFormat.longPrice(detail)
        : detail.toString();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      height: 52,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        children: [
          Assets.icons.squareCheckBig.svg(width: 20, height: 20),
          Gap(15),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.tertiary,
            ),
          ),
          Gap(5),
          Expanded(
            flex: 2,
            child: Text(
              formattedDetail,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonSubcribeWidget extends StatelessWidget {
  final int total;
  final VoidCallback onTap;

  const _ButtonSubcribeWidget({required this.onTap, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xff50C2C9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              AppFormat.longPrice(total),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  'Berlangganan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
