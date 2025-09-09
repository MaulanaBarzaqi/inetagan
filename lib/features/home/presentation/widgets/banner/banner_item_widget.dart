import 'package:flutter/material.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';
import 'banner_image_widget.dart';

class BannerItemWidget extends StatelessWidget {
  final BannerEntity banner;

  const BannerItemWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    // jika banner tidak memiliki image, tampilkan broken image + title
    if (!banner.hasImage) {
      return _buildBannerWithoutImage();
    }
    // jika banner memiliki image, tampilkan image dengan fallback
    return SizedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BannerImageWidget(banner: banner),
      ),
    );
  }

  Widget _buildBannerWithoutImage() {
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
