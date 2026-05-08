import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../pages/order_page.dart';

class OrderFilterTabs extends StatelessWidget {
  final OrderFilter selected;
  final ValueChanged<OrderFilter> onSelected;

  const OrderFilterTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _tabs = [
    (OrderFilter.all, 'All'),
    (OrderFilter.processing, 'Processing'),
    (OrderFilter.orderFailed, 'Order Failed'),
    (OrderFilter.successful, 'Successful'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: _tabs.map((tab) {
          final isSelected = selected == tab.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelected(tab.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 1.2,
                  ),
                ),
                child: Text(
                  tab.$2,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
