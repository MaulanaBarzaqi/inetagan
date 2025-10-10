import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import '../../../../../routes/app_router.dart';
import '../../../../internet-package/presentation/widgets/package_list/package_image_widget.dart';

class PackageSpecialItemWidget extends StatelessWidget {
  final InternetPackageEntity package;
  final int index;
  final int total;

  const PackageSpecialItemWidget({
    super.key,
    required this.package,
    required this.index,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final margin = EdgeInsets.only(
      left: index == 0 ? 0 : 12,
      right: index == total - 1 ? 0 : 12,
    );

    return GestureDetector(
      onTap: () => DetailRoute($extra: package).push(context),
      child: Container(
        width: 252,
        margin: margin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            PackageImageWidget(package: package, width: 220, height: 170),
            const SizedBox(height: 20),
            // Content section
            Text(
              package.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.tertiary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              package.idealDevice,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Row(
                children: [
                  Text(
                    AppFormat.longPrice(package.monthlyBill),
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
            ),
          ],
        ),
      ),
    );
  }
}
