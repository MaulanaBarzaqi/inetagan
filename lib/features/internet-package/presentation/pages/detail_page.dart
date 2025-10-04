import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/button_subscribe_widget.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/detail_item_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';
import 'package:inetagan/routes/app_router.dart';

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
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Gap(30),
          card(),
          Gap(10),
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
            onTap: () => DashboardRoute().replace(context),
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
            'Detail Paket Internet',
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

  card() {
    final int total =
        widget.internetPackage.monthlyBill +
        widget.internetPackage.installation;
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
            widget.internetPackage.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.primary,
            ),
          ),
          Gap(34),
          DetailItemWidget(
            label: 'Untuk',
            detail: widget.internetPackage.idealDevice,
          ),
          Gap(11),
          DetailItemWidget(
            label: 'speed',
            detail: widget.internetPackage.speed,
          ),
          Gap(11),
          DetailItemWidget(
            label: 'kategori',
            detail:
                widget.internetPackage.category?.name ?? 'tidak ada category',
          ),
          Gap(11),
          DetailItemWidget(
            label: 'Biaya Pemasangan',
            detail: widget.internetPackage.installation,
          ),
          Gap(11),
          DetailItemWidget(
            label: 'Biaya Bulanan',
            detail: widget.internetPackage.monthlyBill,
          ),
          Gap(50),
          ButtonSubcribeWidget(
            onTap: () {
              // SubscribeRoute().go(context, extra: package);
              // context.pushNamed(
              //   RouteNames.subscribe,
              //   extra: widget.internetPackage,
              // );
              context.push(
                '/dashboard/subscribe',
                extra: widget.internetPackage,
              );
            },
            total: total,
          ),
        ],
      ),
    );
  }
}
