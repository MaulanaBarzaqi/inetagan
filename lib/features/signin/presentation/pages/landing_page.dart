import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_assets.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/signin/presentation/widgets/button_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        children: [
          const Gap(100),
          Image.asset(AppAssets.logo, height: 80),
          const Gap(15),
          Image.asset(AppAssets.splash, height: 350),
          const Gap(30),
          Text(
            'Saatnya beralih ke Fiber, Akses Internet\nSuper cepat dan canggih',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.7,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: ColorsConstants.tertiary,
            ),
          ),
          const Gap(50),
          ButtonWidget(
            ontap: () {
              context.goNamed(RouteNames.signin);
            },
            text: 'explore now',
          ),
          const Gap(30),
        ],
      ),
    );
  }
}
