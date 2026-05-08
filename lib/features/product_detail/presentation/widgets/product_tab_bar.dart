import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum ProductPageSection { detail, review }

class ProductTabBar extends StatelessWidget {
  const ProductTabBar({
    super.key,
    required this.selectedSection,
    required this.reviewCount,
    required this.onSectionSelected,
  });

  final ProductPageSection selectedSection;
  final int reviewCount;
  final ValueChanged<ProductPageSection> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1.2),
          bottom: BorderSide(color: AppColors.border, width: 1.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabItem(
              label: 'Detail',
              isSelected: selectedSection == ProductPageSection.detail,
              onTap: () => onSectionSelected(ProductPageSection.detail),
            ),
          ),
          Expanded(
            child: _TabItem(
              label: 'Review($reviewCount)',
              isSelected: selectedSection == ProductPageSection.review,
              onTap: () => onSectionSelected(ProductPageSection.review),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.textPrimary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isSelected
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
