import 'package:flutter/material.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';

class PackageImagePlaceholderWidget extends StatelessWidget {
  final InternetPackageEntity package;
  final double width;
  final double height;

  const PackageImagePlaceholderWidget({
    super.key,
    required this.package,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, size: 24, color: Colors.grey),
            const SizedBox(height: 4),
            Text(
              package.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
