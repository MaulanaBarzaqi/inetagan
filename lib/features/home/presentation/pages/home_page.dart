import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/features/features.dart';

import '../widgets/banners/home_banner_section.dart';
import '../widgets/home_all_package_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_featured_section.dart';
import '../widgets/special/home_special_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bannerController = PageController();

  Future<void> _fecthInitialData() async {
    context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
    context.read<BannerBloc>().add(OnBannerEvent());
    context.read<ProfileCubit>().getProfile();
    context.read<NotificationsCubit>().loadNotifications();
  }

  @override
  void initState() {
    _fecthInitialData();
    super.initState();
  }

  @override
  void dispose() {
    bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: RefreshIndicator.adaptive(
        onRefresh: _fecthInitialData,
        child: ListView(
          children: [
            Gap(20),
            HomeBannerSection(bannerController: bannerController),
            Gap(20),
            HomeFeaturedSection(),
            Gap(20),
            HomeSpecialSection(),
            Gap(20),
            HomeAllPackageSection(),
          ],
        ),
      ),
    );
  }
}
