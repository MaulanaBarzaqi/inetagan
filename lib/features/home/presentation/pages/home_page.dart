import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_session.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';
import 'package:inetagan/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:inetagan/features/home/presentation/widgets/banner_widget.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/presentation/bloc/all_internet_package/all_internet_package_bloc.dart';
import 'package:inetagan/features/signin/data/models/sign_in_model.dart';
import 'package:inetagan/gen/assets.gen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:inetagan/features/internet-package/presentation/widgets/package_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bannerController = PageController();
  SignInModel? currentUser;

  refresh() {
    context.read<AllInternetPackageBloc>().add(OnAllInternetPackageEvent());
    context.read<BannerBloc>().add(OnBannerEvent());
  }

  @override
  void initState() {
    refresh();
    _loadUser();
    super.initState();
  }

  Future<void> _loadUser() async {
    final user = await AppSession.getUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async => refresh(),
        child: ListView(
          children: [
            Gap(30),
            header(),
            Gap(20),
            banner(),
            Gap(20),
            featured(),
            Gap(20),
            special(),
            Gap(20),
            allPackages(),
          ],
        ),
      ),
    );
  }

  header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            padding: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              child: Assets.icons.circleUser.svg(height: 24, width: 24),
            ),
          ),
          SizedBox(width: 8),
          Text(
            currentUser != null ? 'Hi, ${currentUser!.name}' : 'Hi, User',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: AppColors.tertiary,
            ),
          ),
          Spacer(),
          Icon(Icons.notifications_none),
        ],
      ),
    );
  }

  banner() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerLoading) {
              return BannerLoadingWidget();
            }
            if (state is BannerFailed) {
              return BannerErrorWidget(message: state.message);
            }
            if (state is BannerSuccess) {
              List<BannerEntity> list = state.data;
              // Jika tidak ada data banner sama sekali
              if (list.isEmpty) {
                return BannerEmptyWidget();
              }
              // Filter hanya banner yang tidak di-delete
              final activeBanners = list
                  .where((banner) => !banner.isDeleted)
                  .toList();
              // Jika tidak ada active banners
              if (activeBanners.isEmpty) {
                return BannerEmptyWidget();
              }
              return BannerCarouselWidget(
                banners: activeBanners,
                controller: bannerController,
              );
            }
            return BannerLoadingWidget();
          },
        ),
        Gap(10),
        BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerSuccess) {
              final activeBanners = state.data
                  .where((banner) => !banner.isDeleted)
                  .toList();
              if (activeBanners.length > 1) {
                return SmoothPageIndicator(
                  controller: bannerController,
                  count: activeBanners.length,
                  effect: WormEffect(
                    dotColor: AppColors.tertiary,
                    activeDotColor: AppColors.primary,
                    dotHeight: 9,
                    dotWidth: 9,
                  ),
                );
              }
            }
            return SizedBox();
          },
        ),
      ],
    );
  }

  featured() {
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

  special() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Paket Special',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.secondary,
            ),
          ),
        ),
        Gap(10),
        BlocBuilder<AllInternetPackageBloc, AllInternetPackageState>(
          builder: (context, state) {
            if (state is AllInternetPackageLoading) {
              return SizedBox(
                height: 295,
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }
            if (state is AllInternetPackageFailed) {
              return FailedWidget(height: 295, message: state.message);
            }
            if (state is AllInternetPackageSuccess) {
              List<InternetPackageEntity> list = state.data;
              if (list.isEmpty) {
                return EmptyWidget(height: 295);
              }
              return SizedBox(
                height: 295,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return PackageSpecialItemWidget(
                      package: list[index],
                      index: index,
                      total: list.length,
                    );
                  },
                ),
              );
            }
            return SizedBox(
              height: 295,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          },
        ),
      ],
    );
  }

  allPackages() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Paket Internet",
                style: TextStyle(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          BlocBuilder<AllInternetPackageBloc, AllInternetPackageState>(
            builder: (context, state) {
              if (state is AllInternetPackageLoading) {
                return SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
              if (state is AllInternetPackageFailed) {
                return FailedWidget(height: 200, message: state.message);
              }
              if (state is AllInternetPackageSuccess) {
                List<InternetPackageEntity> list = state.data;
                // Jika tidak ada data package
                if (list.isEmpty) {
                  return EmptyWidget(height: 200);
                }
                return ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PackageListItemWidget(package: list[index]);
                  },
                );
              }
              return SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            },
          ),
        ],
      ),
    );
  }
}
