// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';
import 'package:inetagan/features/home/presentation/widgets/banner_item_widget.dart';

class BannerCarouselWidget extends StatelessWidget {
  final List<BannerEntity> banners;
  final PageController controller;

  const BannerCarouselWidget({
    super.key,
    required this.banners,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: PageView.builder(
        itemCount: banners.length,
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BannerItemWidget(banner: banner),
          );
        },
      ),
    );
  }
}
