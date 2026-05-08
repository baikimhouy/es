import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? labelColor;
  final Color? iconColor;
  final bool showArrow;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.labelColor,
    this.iconColor,
    this.showArrow = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedIcon = iconColor ?? AppColors.primary;
    final resolvedLabel = labelColor ?? AppColors.textPrimary;

    return Material(
      color: AppColors.surface, // solid white surface
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primaryLight, // solid light pink splash
        highlightColor: AppColors.primaryLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              // icon container — solid light pink background
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: resolvedIcon, size: 20),
              ),

              const SizedBox(width: 14),

              // label
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: resolvedLabel,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // trailing widget or arrow
              if (trailing != null)
                trailing!
              else if (showArrow)
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textSecondary, // solid muted arrow
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
