import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/widgets/button_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';

class SuccessSubscribePage extends StatelessWidget {
  const SuccessSubscribePage({super.key});

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
                    'Selamat Pengajuan Anda Berhasil !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: AppColors.primary,
                    ),
                  ),
                  Assets.images.imgSuccess.image(height: 225),
                  Text(
                    'Paket 10 Mbps',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'pengajuan anda berhasil di kirimkan untuk diproses, silahkan tunggu info lebih lanjutnya.',
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
            child: ButtonWidget(ontap: () {}, text: 'Kembali ke Home'),
          ),
        ],
      ),
    );
  }
}
