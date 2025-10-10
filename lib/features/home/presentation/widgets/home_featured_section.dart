import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../gen/assets.gen.dart';

class HomeFeaturedSection extends StatelessWidget {
  const HomeFeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = <Map<String, dynamic>>[
      {'label': 'Pembayaran', 'icon': Assets.icons.wallet},
      {'label': 'Upgrade Kecepatan', 'icon': Assets.icons.wifiPen},
      {'label': 'Downgrade Kecepatan', 'icon': Assets.icons.wifiCog},
      {'label': 'Berhenti Berlangganan', 'icon': Assets.icons.wifiOff},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Menu Tambahan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
        ),
        const Gap(10),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: features.map((e) {
                return Container(
                  height: 52,
                  margin: const EdgeInsets.only(right: 24),
                  padding: const EdgeInsets.fromLTRB(16, 14, 30, 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      (e['icon'] as SvgGenImage).svg(width: 24, height: 24),
                      Gap(10),
                      Text(
                        e['label'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
