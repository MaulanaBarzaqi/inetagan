import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';
import 'package:inetagan/core/widgets/button_widget.dart';
import 'package:inetagan/features/home/presentation/widgets/circle_loading_widget.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/subscribe/presentation/widgets/detail_item_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';

class DetailSubscribePage extends StatefulWidget {
  const DetailSubscribePage({super.key, required this.internetPackage});
  final InternetPackageEntity internetPackage;

  @override
  State<DetailSubscribePage> createState() => _DetailSubscribePageState();
}

class _DetailSubscribePageState extends State<DetailSubscribePage> {
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
          buildDetail(),
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
                DetailItemWidget(label: 'nama', itemDetail: 'maulana'),
                DetailItemWidget(label: 'NIK', itemDetail: '088212312343'),
                DetailItemWidget(label: 'WhatsApp', itemDetail: '02913902382'),
                DetailItemWidget(
                  label: 'Alamat',
                  itemDetail: 'Jl. Raya No. 123, Jakarta Selatan',
                ),
                DetailItemWidget(
                  label: 'Biaya Bulanan',
                  itemDetail: widget.internetPackage.monthlyBill,
                ),
                DetailItemWidget(
                  label: 'Biaya Pemasangan',
                  itemDetail: widget.internetPackage.installation,
                ),
                Text(
                  'Total Biaya',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.tertiary,
                  ),
                ),
                Gap(15),
                Text(
                  AppFormat.longPrice(total),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const Gap(30),
          ButtonWidget(ontap: () {}, text: 'Ajukan'),
        ],
      ),
    );
  }
}
