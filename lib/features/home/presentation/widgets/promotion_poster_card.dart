import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/promotion_model.dart';
import '../pages/promotion_detail_page.dart';

class PromotionPosterCard extends StatelessWidget {
  final PromotionModel promotion;

  const PromotionPosterCard({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PromotionDetailPage(promotion: promotion),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Poster image ──────────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: AspectRatio(
              aspectRatio: 1.0, // square poster; adjust to 4/3 etc. as needed
              child: Image.network(
                promotion.posterUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : Container(
                        color: AppColors.divider,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.divider,
                  child: const Icon(
                    Icons.image_outlined,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // ── Title ─────────────────────────────────────────────────────
          Text(
            promotion.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
