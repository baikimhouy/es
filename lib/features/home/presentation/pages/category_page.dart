// lib/features/home/presentation/pages/category_page.dart
import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/constants/category_constants.dart';
import '../widgets/product_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _selectedFilter = 'All';

  List<String> _filtersFor(String title) =>
      kCategoryFilters[title] ?? kDefaultFilters;

  // ── Core filter logic — every chip case handled ─────────────────────────
  List<ProductModel> _applyFilter(String categoryTitle, String filter) {
    // Start with products relevant to this category
    List<ProductModel> base = _baseProducts(categoryTitle);

    switch (filter) {
      // ── Price range ──────────────────────────────────────────
      case 'Under \$10':
        return base.where((p) => p.price < 10).toList();
      case 'Under \$20':
        return base.where((p) => p.price < 20).toList();
      case 'Under \$30':
        return base.where((p) => p.price < 30).toList();
      case 'Price: Low':
        return [...base]..sort((a, b) => a.price.compareTo(b.price));
      case 'Price: High':
        return [...base]..sort((a, b) => b.price.compareTo(a.price));

      // ── Rating / recency ─────────────────────────────────────
      case 'Top Rated':
        return (base.where((p) => p.tags.contains('Top Rated')).toList()
          ..sort((a, b) => b.rating.compareTo(a.rating)));
      case 'Best Seller':
        return base.where((p) => p.tags.contains('Best Seller')).toList();
      case 'New':
      case 'This Week':
      case 'This Month':
        return base.where((p) => p.tags.contains('New')).toList();

      case 'Up to 30% off':
        return base.where((p) => p.price < 20).toList(); // budget items
      case 'Up to 50% off':
        return base
            .where((p) => p.price >= 20 && p.price < 35)
            .toList(); // mid-range
      case 'Up to 70% off':
        return base.where((p) => p.price >= 35).toList(); // premium items

      // ── Time Deal ────────────────────────────────────────────
      case 'Flash Sale':
        return base.where((p) => p.tags.contains('Flash Sale')).toList();
      case 'Ending Soon':
      case 'Today Only':
        // No time data in model yet — show all base products.
        return base;

      // ── Skincare product types ────────────────────────────────
      case 'Cleanser':
      case 'Toner':
      case 'Serum':
      case 'Moisturiser':
      case 'Sunscreen':
        return base.where((p) => p.type == filter).toList();

      // ── Make Up product types ─────────────────────────────────
      case 'Foundation':
      case 'Lip':
      case 'Eye':
      case 'Blush':
      case 'Primer':
        return base.where((p) => p.type == filter).toList();

      // ── Supplement types ─────────────────────────────────────
      case 'Collagen':
      case 'Vitamins':
      case 'Antioxidant':
      case 'Detox':
        return base.where((p) => p.type == filter).toList();

      // ── Beauty Tools types ────────────────────────────────────
      case 'Face':
      case 'Hair':
      case 'Body':
      case 'Nails':
        return base.where((p) => p.type == filter).toList();

      // ── All / fallback ────────────────────────────────────────
      default:
        return base;
    }
  }

  // Returns the base product set for a category.
  // Falls back to all products when no category match.
  List<ProductModel> _baseProducts(String categoryTitle) {
    switch (categoryTitle) {
      case 'Skincare':
        return sampleProducts
            .where((p) => p.tags.contains('Skincare'))
            .toList();
      case 'Make Up':
        return sampleProducts.where((p) => p.tags.contains('Make Up')).toList();
      case 'Supplement':
        return sampleProducts
            .where((p) => p.tags.contains('Supplement'))
            .toList();
      case 'Beauty Tools':
        return sampleProducts
            .where((p) => p.tags.contains('Beauty Tools'))
            .toList();
      case 'Best Deal':
        return sampleProducts
            .where((p) => p.tags.contains('Best Seller'))
            .toList();
      case 'New Arrivals':
        return sampleProducts.where((p) => p.tags.contains('New')).toList();
      case 'Clearance Sale':
      case 'Time Deal':
        return sampleProducts; // show full catalogue with discount badge
      default:
        return sampleProducts;
    }
  }

  int? _discountFor(String categoryTitle) {
    if (kFilterDiscounts.containsKey(_selectedFilter)) {
      return kFilterDiscounts[_selectedFilter];
    }
    if (kCategoryDiscounts.containsKey(categoryTitle)) {
      return kCategoryDiscounts[categoryTitle];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    final filters = _filtersFor(title);

    if (!filters.contains(_selectedFilter)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _selectedFilter = 'All');
      });
    }

    final products = _applyFilter(title, _selectedFilter);
    final discount = _discountFor(title);

    final double systemBottom = MediaQuery.of(context).viewPadding.bottom;
    final double scrollBottomPadding = 72.0 + systemBottom + 12.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textSecondary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            color: AppColors.textSecondary,
            onPressed: () => Navigator.pushNamed(context, AppRouter.search),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            color: AppColors.textSecondary,
            onPressed: () => Navigator.pushNamed(context, AppRouter.cart),
          ),
        ],
      ),


      body: Column(
        children: [
          // ── Filter chips ──────────────────────────────────────
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      filter,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? AppColors.surface
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1, color: AppColors.border),

          // ── Product count hint ────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${products.length} product${products.length == 1 ? '' : 's'}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // ── Product grid ──────────────────────────────────────
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: AppColors.border,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No products found.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      scrollBottomPadding,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.62,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) => ProductCard(
                      product: products[index],
                      discountPercent: discount,
                      isNewArrival: title == 'New Arrivals',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
