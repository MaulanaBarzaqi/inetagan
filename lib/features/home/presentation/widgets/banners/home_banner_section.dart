import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/home/presentation/widgets/banners/banner_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/entities/banner_entity.dart';
import '../../bloc/banner/banner_bloc.dart';

// ORCHESTRATOR
class HomeBannerSection extends StatelessWidget {
  final PageController bannerController;
  const HomeBannerSection({super.key, required this.bannerController});

  List<BannerEntity> _getActiveBanners(List<BannerEntity> allBanners) {
    return allBanners.where((banner) => !banner.isDeleted).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _BannerCarousel(
          bannerController: bannerController,
          getActiveBanners: _getActiveBanners,
        ),
        Gap(10),
        _BannerPageIndicator(
          bannerController: bannerController,
          getActiveBanners: _getActiveBanners,
        ),
      ],
    );
  }
}

// logic to show loading,error,empty, or carrousel
class _BannerCarousel extends StatelessWidget {
  final PageController bannerController;
  final List<BannerEntity> Function(List<BannerEntity>) getActiveBanners;

  const _BannerCarousel({
    required this.bannerController,
    required this.getActiveBanners,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerLoading) {
          return BannerLoadingWidget();
        }
        if (state is BannerFailed) {
          return BannerErrorWidget(message: state.message);
        }
        if (state is BannerSuccess) {
          final activeBanners = getActiveBanners(state.data);

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
    );
  }
}

// logic to show page controller banners
class _BannerPageIndicator extends StatelessWidget {
  final PageController bannerController;
  final List<BannerEntity> Function(List<BannerEntity>) getActiveBanners;

  const _BannerPageIndicator({
    required this.bannerController,
    required this.getActiveBanners,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      buildWhen: (previous, current) => current is BannerSuccess,
      builder: (context, state) {
        if (state is BannerSuccess) {
          final activeBanners = getActiveBanners(state.data);
          if (activeBanners.length > 1) {
            return SmoothPageIndicator(
              controller: bannerController,
              count: activeBanners.length,
              effect: const WormEffect(
                dotColor: AppColors.tertiary,
                activeDotColor: AppColors.primary,
                dotHeight: 9,
                dotWidth: 9,
              ),
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}
