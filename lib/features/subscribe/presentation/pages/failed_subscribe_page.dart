import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';

class FailedSubscribePage extends StatelessWidget {
  const FailedSubscribePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Gagal Memproses !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: AppColors.primary,
                    ),
                  ),
                  Assets.images.imgFailed.image(height: 225),
                  Gap(10),
                  Text(
                    'Terjadi Kesalahan saat memuat aplikasi, Silahkan coba kembali nanti.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonWidget(
              ontap: () {
                context.goNamed(RouteNames.dashboard);
              },
              text: 'Kembali ke Home',
            ),
          ),
        ],
      ),
    );
  }
}
