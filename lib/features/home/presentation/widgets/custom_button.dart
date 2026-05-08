import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOutline;
  final bool isLoading;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutline = false,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color( 0xFFFFFFFF),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: isOutline ? AppColors.primary : Color( 0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),)
                // style: AppStyles.bodyMedium.copyWith(
                //     fontWeight: FontWeight.w600,
                //     color: isOutline ? AppColors.primary : AppColors.white ),
            ],
          );

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: isOutline
          ? OutlinedButton(onPressed: isLoading ? null : onPressed, child: child)
          : ElevatedButton(onPressed: isLoading ? null : onPressed, child: child),
    );
  }
}
