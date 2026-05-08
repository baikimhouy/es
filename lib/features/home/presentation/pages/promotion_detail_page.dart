import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/promotion_model.dart';
import '../widgets/product_card.dart';

class PromotionDetailPage extends StatelessWidget {
  final PromotionModel promotion;

  const PromotionDetailPage({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ── AppBar ─────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: AppColors.secondary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/app_logo.png',
          height: 30,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => Text(
            'GlowUp',
            style: tt.titleMedium?.copyWith(color: AppColors.primary),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            color: AppColors.secondary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            color: AppColors.secondary,
            onPressed: () {},
          ),
        ],
      ),

      // ── Body ───────────────────────────────────────────────────────────
      body: CustomScrollView(
        slivers: [
          // ── Big poster ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Image.network(
              promotion.posterUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) => progress == null
                  ? child
                  : SizedBox(
                      height: 260,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
              errorBuilder: (_, _, _) => Container(
                height: 260,
                color: AppColors.divider,
                child: const Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: Text(
                promotion.title,
                textAlign: TextAlign.center,
                style: tt.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),

          // ── Divider ──────────────────────────────────────────────────
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(color: AppColors.divider, thickness: 1),
            ),
          ),

          // ── Product grid ─────────────────────────────────────────────
          promotion.products.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'No products available.',
                        style: tt.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.62,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          ProductCard(product: promotion.products[index]),
                      childCount: promotion.products.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
