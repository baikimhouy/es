import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StarRow extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const StarRow({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars  = rating.floor();
    final hasHalf    = (rating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalf ? 1 : 0);

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
        if (hasHalf)
          const Icon(Icons.star_half_rounded, size: 14, color: AppColors.star),
        for (int i = 0; i < emptyStars; i++)
          const Icon(Icons.star_outline_rounded, size: 14, color: AppColors.star),
        const SizedBox(width: 4),
        if (reviewCount > 0)
          Text(
            '($reviewCount)',
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
      ],
    );
  }
}