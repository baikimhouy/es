// lib/features/home/presentation/widgets/home_category_grid.dart
//
// Each item pushes AppRouter.category with the label as the argument.
// CategoryPage receives it via ModalRoute.of(context)!.settings.arguments.
// One route handles every category — no need for /best-deal, /skincare, etc.

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/router/app_router.dart';

class HomeCategoryGrid extends StatelessWidget {
  const HomeCategoryGrid({super.key});

  static const List<_HomeCategoryItem> _items = [
    _HomeCategoryItem('Best Deal', 'assets/images/beauty 1.png'),
    _HomeCategoryItem('New Arrivals', 'assets/images/day-cream 1.png'),
    _HomeCategoryItem(
      'Clearance Sale',
      'assets/images/essential-oil (2) 1.png',
    ),
    _HomeCategoryItem('Time Deal', 'assets/images/gel 1.png'),
    _HomeCategoryItem('Skincare', 'assets/images/serum (1) 1.png'),
    _HomeCategoryItem('Make Up', 'assets/images/makeup 1.png'),
    _HomeCategoryItem('Supplement', 'assets/images/beauty-treatment (2) 1.png'),
    _HomeCategoryItem('Beauty Tools', 'assets/images/nail-polish (2) 1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisExtent: 82,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.fromLTRB(5, 12, 5, 4),
        itemBuilder: (context, index) {
          final item = _items[index];
          return GestureDetector(
            // Pass the category label as the route argument.
            // CategoryPage reads it with:
            //   final title = ModalRoute.of(context)!.settings.arguments as String;
            onTap: () => Navigator.pushNamed(
              context,
              AppRouter.category,
              arguments: item.label,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.spa_outlined,
                      size: 36,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HomeCategoryItem {
  const _HomeCategoryItem(this.label, this.image);
  final String label;
  final String image;
  // route field removed — all categories share AppRouter.category
}
