import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileHeaderBanner extends StatelessWidget {
  final String name;
  final String email;
  final Widget avatarWidget;

  const ProfileHeaderBanner({
    super.key,
    required this.name,
    required this.email,
    required this.avatarWidget,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      color: AppColors.primary, // solid light pink, no opacity
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Row(
        children: [
          avatarWidget,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: tt.titleMedium?.copyWith(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: tt.bodySmall?.copyWith(color: AppColors.primaryLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
