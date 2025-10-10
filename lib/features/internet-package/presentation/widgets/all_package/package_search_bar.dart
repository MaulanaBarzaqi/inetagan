import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/config/app_colors.dart';

class PackageSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearchPressed;
  final ValueChanged<String>? onSubmitted;
  const PackageSearchBar({
    super.key,
    required this.controller,
    required this.onSearchPressed,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.tertiary, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: 'Cari paket internet...',
              ),
            ),
          ),
          const Gap(10),
          IconButton.filledTonal(
            onPressed: () => onSearchPressed(),
            icon: const Icon(Icons.search, size: 24),
          ),
        ],
      ),
    );
  }
}
