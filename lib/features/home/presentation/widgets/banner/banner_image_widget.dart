import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';

class BannerImageWidget extends StatelessWidget {
  final BannerEntity banner;

  const BannerImageWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      AppConstant.imageBanner(banner.image!),
      fit: BoxFit.cover,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return _buildImageLoading();
          case LoadState.failed:
            return _buildImageFailed();
          case LoadState.completed:
            return null;
        }
      },
    );
  }

  Widget _buildImageLoading() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _buildImageFailed() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, size: 40, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              banner.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
