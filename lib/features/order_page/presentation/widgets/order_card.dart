import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../pages/order_page.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  Color _statusBg(OrderFilter status) {
    switch (status) {
      case OrderFilter.processing:
        return AppColors.warningLight;
      case OrderFilter.successful:
        return AppColors.successLight;
      case OrderFilter.orderFailed:
        return AppColors.errorLight;
      case OrderFilter.all:
        return AppColors.primaryLight;
    }
  }

  Color _statusText(OrderFilter status) {
    switch (status) {
      case OrderFilter.processing:
        return AppColors.warning;
      case OrderFilter.successful:
        return AppColors.success;
      case OrderFilter.orderFailed:
        return AppColors.error;
      case OrderFilter.all:
        return AppColors.primary;
    }
  }

  String _statusLabel(OrderFilter status) {
    switch (status) {
      case OrderFilter.processing:
        return 'Processing';
      case OrderFilter.orderFailed:
        return 'Failed';
      case OrderFilter.successful:
        return 'Delivered';
      case OrderFilter.all:
        return '';
    }
  }

  // ── Smart image: network OR asset ────────────────────────────────────────
  Widget _buildImage(String imageUrl) {
    final isNetwork = imageUrl.startsWith('http');

    final placeholder = Container(
      width: 72,
      height: 72,
      color: AppColors.primaryLight,
      child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 72,
        height: 72,
        child: isNetwork
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.divider,
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                },
                errorBuilder: (_, _, _) => placeholder,
              )
            : Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => placeholder,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final OrderFilter status = order['status'];
    final bool hasDeliveryBadge = order['hasDeliveryBadge'];
    final double price = order['price'];
    final int quantity = order['quantity'];
    final String imageUrl = order['image'] ?? '';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // ── Image with optional delivery badge ──────────────────
            Stack(
              children: [
                _buildImage(imageUrl),
                if (hasDeliveryBadge)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // ── Info ────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _statusBg(status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel(status),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _statusText(status),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    order['name'],
                    style: tt.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    order['description'],
                    style: tt.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    order['brand'],
                    style: tt.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: tt.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // ── Quantity bubble ─────────────────────────────────────
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'x$quantity',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
