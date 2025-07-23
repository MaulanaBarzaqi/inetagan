import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/widgets/button_widget.dart';
import 'package:inetagan/features/signin/data/datasources/sign_in_local_datasource.dart';
import 'package:inetagan/gen/assets.gen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final SignInLocalDatasource local = SignInLocalDatasourceImpl();

  @override
  void initState() {
    handleRedirect();
    super.initState();
  }

  Future<void> handleRedirect() async {
    final route = await local.getRedirectRoute();
    if (route != null) {
      context.goNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        children: [
          const Gap(100),
          Assets.images.imgLogoInetagan.image(height: 80),
          const Gap(15),
          Assets.images.imgSplashscreen.image(height: 350),
          const Gap(30),
          Text(
            'Saatnya beralih ke Fiber, Akses Internet\nSuper cepat dan canggih',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.7,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: AppColors.tertiary,
            ),
          ),
          const Gap(50),
          ButtonWidget(
            ontap: () async {
              await local.setHasLaunched();
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
