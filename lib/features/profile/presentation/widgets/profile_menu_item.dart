import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../gen/assets.gen.dart';

class ProfileMenuItem extends StatelessWidget {
  final SvgGenImage icon;
  final String label;
  final VoidCallback onTap;
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 52,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.primary, width: 1),
          ),
          child: Row(
            children: [
              icon.svg(width: 24, height: 24),
              const Gap(14),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.secondary,
                ),
              ),
              const Spacer(),
              Assets.icons.chevronRight.svg(height: 24, width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
