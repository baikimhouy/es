import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_review.dart';
import 'rating_stars.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ProductReview review;

  @override
  Widget build(BuildContext context) {
    final reviewImage = switch ((review.fileImagePath, review.assetPath)) {
      (final filePath?, _) => Image.file(File(filePath), fit: BoxFit.cover),
      (_, final assetPath?) => Image.asset(assetPath, fit: BoxFit.cover),
      _ => null,
    };

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ReviewAvatar(review: review),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.dateLabel,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RatingStars(rating: review.rating, size: 30),
          const SizedBox(height: 18),
          Text(
            review.comment,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 17, height: 1.6),
          ),
          if (reviewImage != null) ...[
            const SizedBox(height: 20),
            Container(
              width: 170,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF8E3D8), Color(0xFFE6D0C2)],
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  reviewImage,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.06),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.22),
                        ],
                        stops: const [0, 0.45, 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: review.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.reviewChipBackground,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tag,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.reviewChipText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ReviewAvatar extends StatelessWidget {
  const _ReviewAvatar({required this.review});

  final ProductReview review;

  @override
  Widget build(BuildContext context) {
    if (review.profileAssetPath case final profileAssetPath?) {
      return CircleAvatar(
        radius: 28,
        backgroundColor: AppColors.secondary.withValues(alpha: 0.25),
        child: ClipOval(
          child: Image.asset(
            profileAssetPath,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 28,
      backgroundColor: AppColors.secondary.withValues(alpha: 0.5),
      child: Text(
        review.avatarText,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
