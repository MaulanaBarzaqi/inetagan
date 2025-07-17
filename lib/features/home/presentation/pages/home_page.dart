import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_assets.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/presentation/bloc/all_internetplan/all_internetplan_bloc.dart';
import 'package:inetagan/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:inetagan/features/home/presentation/widgets/circle_loading_widget.dart';
import 'package:inetagan/features/home/presentation/widgets/text_failure_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bannerController = PageController();

  refresh() {
    context.read<AllInternetplanBloc>().add(OnAllInternetplanEvent());
    context.read<BannerBloc>().add(OnBannerEvent());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
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
          allInternetPackages(),
        ],
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
              backgroundImage: AssetImage(AppAssets.icAccount),
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Hi, Maulana!',
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
              return CircleLoadingWidget();
            }
            if (state is BannerFailed) {
              return TextFailureWidget(message: state.message);
            }
            if (state is BannerSuccess) {
              List<BannerEntity> list = state.data;
              return AspectRatio(
                aspectRatio: 2.5,
                child: PageView.builder(
                  itemCount: list.length,
                  controller: bannerController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    BannerEntity banner = list[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ExtendedImage.network(
                            banner.image,
                            fit: BoxFit.cover,
                            handleLoadingProgress: true,
                            loadStateChanged: (state) {
                              if (state.extendedImageLoadState ==
                                  LoadState.failed) {
                                return AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }
                              if (state.extendedImageLoadState ==
                                  LoadState.loading) {
                                return AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[300],
                                    child: const CircleLoadingWidget(),
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
        Gap(10),
        BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerSuccess) {
              return SmoothPageIndicator(
                controller: bannerController,
                count: state.data.length,
                effect: WormEffect(
                  dotColor: AppColors.tertiary,
                  activeDotColor: AppColors.primary,
                  dotHeight: 9,
                  dotWidth: 9,
                ),
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }

  featured() {
    final features = [
      ['Pembayaran', AppAssets.icWallet],
      ['Upgrade Kecepatan', AppAssets.icWifiUp],
      ['Downgrade Kecepatan', AppAssets.icWifiDown],
      ['Berhenti Berlangganan', AppAssets.icWifiOff],
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
                      Image.asset(e[1], width: 24, height: 24),
                      const Gap(10),
                      Text(
                        e[0],
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
          padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
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
        BlocBuilder<AllInternetplanBloc, AllInternetplanState>(
          builder: (context, state) {
            if (state is AllInternetplanLoading) {
              return CircleLoadingWidget();
            }
            if (state is AllInternetplanFailed) {
              return TextFailureWidget(message: state.message);
            }
            if (state is AllInternetplanSuccess) {
              List<InternetplanEntity> list = state.data;
              return SizedBox(
                height: 295,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    InternetplanEntity internetPlan = list[index];
                    final margin = EdgeInsets.only(
                      left: index == 0 ? 24 : 12,
                      right: index == list.length - 1 ? 24 : 12,
                    );
                    return buildItemSpecial(internetPlan, margin);
                  },
                ),
              );
            }
            return SizedBox(height: 120);
          },
        ),
      ],
    );
  }

  Widget buildItemSpecial(
    InternetplanEntity internetPlan,
    EdgeInsetsGeometry margin,
  ) {
    return Container(
      width: 252,
      margin: margin,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExtendedImage.network(
            internetPlan.image,
            width: 220,
            height: 170,
            fit: BoxFit.cover,
            handleLoadingProgress: true,
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.failed) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.black),
                  ),
                );
              }
              if (state.extendedImageLoadState == LoadState.loading) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[300],
                    child: CircleLoadingWidget(),
                  ),
                );
              }
              return null;
            },
          ),
          Gap(20),
          Text(
            internetPlan.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.tertiary,
            ),
          ),
          Gap(2),
          Text(
            internetPlan.idealDevice,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
          Gap(2),
          Row(
            children: [
              Text(
                AppFormat.longPrice(internetPlan.monthlyBill),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '/Bulan',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  allInternetPackages() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
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
              Text(
                "Lihat Semua",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const Gap(16),
          BlocBuilder<AllInternetplanBloc, AllInternetplanState>(
            builder: (context, state) {
              if (state is AllInternetplanLoading) {
                return const CircleLoadingWidget();
              }
              if (state is AllInternetplanFailed) {
                return TextFailureWidget(message: state.message);
              }
              if (state is AllInternetplanSuccess) {
                List<InternetplanEntity> list = state.data;
                return ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    InternetplanEntity internetPlan = list[index];
                    return itemAllInternetPackages(internetPlan);
                  },
                );
              }
              return const SizedBox(height: 120);
            },
          ),
        ],
      ),
    );
  }

  Widget itemAllInternetPackages(InternetplanEntity internetPlan) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ExtendedImage.network(
                internetPlan.image,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                handleLoadingProgress: true,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                        child: const CircleLoadingWidget(),
                      ),
                    );
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
                    internetPlan.name,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      height: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    internetPlan.idealDevice,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1,
                      fontSize: 14,
                      color: AppColors.tertiary,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    internetPlan.speed,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1,
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
}
