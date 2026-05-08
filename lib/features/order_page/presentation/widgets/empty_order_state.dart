// lib/features/order_page/presentation/widgets/empty_order_state.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class EmptyOrderState extends StatelessWidget {
  const EmptyOrderState({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty.png',
            width: 100,
            height: 100,
            errorBuilder: (_, _, _) => Icon(
              Icons.shopping_bag_outlined,
              size: 72,
              color: AppColors.primaryLight,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "There's no recent activity to show here.",
            style: tt.bodySmall?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
