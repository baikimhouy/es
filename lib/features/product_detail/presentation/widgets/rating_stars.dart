import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.size = 18,
    this.activeColor = AppColors.star,
    this.inactiveColor = const Color(0xFFE3E3E3),
  });

  final double rating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final icon = rating >= starIndex
            ? Icons.star_rounded
            : rating > index
            ? Icons.star_half_rounded
            : Icons.star_rounded;

        final color = rating > index ? activeColor : inactiveColor;

        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(icon, size: size, color: color),
        );
      }),
    );
  }
}
