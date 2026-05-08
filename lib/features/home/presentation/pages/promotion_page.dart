import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/constants/notification_constants.dart';
import '../widgets/promotion_cart.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: AppColors.secondary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Current Promotions',
          style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemCount: sampleNotifications.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final promo = sampleNotifications[index];
          return PromotionCard(
            promotion: promo,
            compact: false,
            // Each card could navigate to a deeper detail page in the future
            onTap: () {
            },
          );
        },
      ),
    );
  }
}
