import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/features/category/domain/entities/category_entity.dart';

class CategoriesTabBar extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int selectedIndex;
  final Function(int) onTabChanged;
  const CategoriesTabBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(categories.length, (i) {
            final category = categories[i];
            final selected = i == selectedIndex;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ChoiceChip(
                side: BorderSide.none,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                label: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? AppColors.primary : AppColors.tertiary,
                  ),
                ),
                selected: selected,
                onSelected: (_) => onTabChanged(i),
                selectedColor: AppColors.primary.withAlpha(60),
              ),
            );
          }),
        ),
      ),
    );
  }
}
