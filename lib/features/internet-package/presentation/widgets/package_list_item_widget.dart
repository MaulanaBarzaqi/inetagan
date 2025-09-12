import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package_image_widget.dart';

class PackageListItemWidget extends StatelessWidget {
  final InternetPackageEntity package;

  const PackageListItemWidget({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => context.goNamed(RouteNames.detail, extra: package),
        child: Row(
          children: [
            // Image
            PackageImageWidget(package: package, width: 100, height: 100),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.name,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package.idealDevice,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package.category?.name ?? 'tidak ada category',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
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
