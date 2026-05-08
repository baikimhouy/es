// lib/features/home/presentation/widgets/product_card.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_model.dart';
import '../../../../core/router/app_router.dart';
import 'badge_widget.dart';
import 'star_row.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isFeatured;
  final bool isNewArrival;
  final int? discountPercent;

  const ProductCard({
    super.key,
    required this.product,
    this.isFeatured = false,
    this.isNewArrival = false,
    this.discountPercent,
  });

  double get _finalPrice {
    if (discountPercent == null) return product.price;
    return product.price * (1 - discountPercent! / 100);
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final hasDiscount = discountPercent != null && discountPercent! > 0;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.productDetail,
        arguments: product,
      ),
      child: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Image + badges ─────────────────────────────────
              Stack(
                children: [
                  Container(
                    height: 155,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: product.imageUrl != null
                          ? Image.network(
                              product.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => _placeholder(),
                            )
                          : _placeholder(),
                    ),
                  ),

                  // Featured pill — top-center
                  if (isFeatured)
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Featured',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // New badge — top-left
                  if (isNewArrival)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: BadgeWidget(
                        label: 'New',
                        color: const Color(0xFF2E7D32),
                      ),
                    ),

                  // Discount badge — top-right
                  if (hasDiscount)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: BadgeWidget(
                        label: '-$discountPercent%',
                        color: AppColors.accent,
                      ),
                    ),
                ],
              ),

              // ── Text details ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      style: tt.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 2),

                    Text(
                      product.description,
                      style: tt.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Price row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${_finalPrice.toStringAsFixed(2)}',
                          style: tt.bodyLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 6),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: tt.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 4),

                    // FIX: was hardcoded const StarRow(rating: 4.0, reviewCount: 10)
                    // now reads directly from ProductModel fields
                    StarRow(
                      rating: product.rating,
                      reviewCount: product.reviewCount,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder() => const Center(
    child: Icon(Icons.spa_outlined, color: AppColors.primary, size: 44),
  );
}
