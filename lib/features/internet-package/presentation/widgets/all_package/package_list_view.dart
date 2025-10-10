import 'package:flutter/material.dart';

import '../../../domain/entities/internet_package_entity.dart';
import '../package_widget.dart';

class PackageListView extends StatelessWidget {
  final List<InternetPackageEntity> list;

  const PackageListView({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const EmptyWidget(height: 300);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final package = list[index];
        return ItemListPackageWidget(package: package);
      },
    );
  }
}
