import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_constant.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package_image_placeholder_widget.dart';

class PackageImageWidget extends StatelessWidget {
  final InternetPackageEntity package;
  final double width;
  final double height;

  const PackageImageWidget({
    super.key,
    required this.package,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        height: height,
        child: package.hasImage
            ? ExtendedImage.network(
                AppConstant.imagePackage(package.image!),
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
              )
            : PackageImagePlaceholderWidget(
                package: package,
                width: width,
                height: height,
              ),
      ),
    );
  }

  Widget _buildImageLoading() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }

  Widget _buildImageFailed() {
    return PackageImagePlaceholderWidget(
      package: package,
      width: width,
      height: height,
    );
  }
}
