// lib/features/order_page/presentation/pages/order_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/pages/notification_screen.dart';
import '../widgets/order_card.dart';
import '../widgets/empty_order_state.dart';

enum OrderFilter { all, orderFailed, processing, successful }

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderFilter _selected = OrderFilter.all;

  final List<Map<String, dynamic>> _allOrders = [
    {
      'id': 'ORD-001',
      'status': OrderFilter.processing,
      'name': 'Blush',
      'description': 'Creates vivid face with gorgeous co...',
      'brand': 'Innisfree',
      'price': 18.70,
      'quantity': 2,
      'image':
          'https://i.pinimg.com/1200x/6b/d1/a5/6bd1a5ceaac536db2c7fc0f5c4a53921.jpg',
      'hasDeliveryBadge': false,
    },
    {
      'id': 'ORD-002',
      'status': OrderFilter.processing,
      'name': 'Sunscreen',
      'description': 'Creates vivid face with gorgeous co...',
      'brand': 'Innisfree',
      'price': 10.00,
      'quantity': 1,
      'image':
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=200&q=80',
      'hasDeliveryBadge': false,
    },
    {
      'id': 'ORD-003',
      'status': OrderFilter.successful,
      'name': 'Sunscreen',
      'description': 'Creates vivid face with gorgeous co...',
      'brand': 'Innisfree',
      'price': 10.00,
      'quantity': 2,
      'image':
          'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=200&q=80',
      'hasDeliveryBadge': true,
    },
  ];

  static const _tabs = [
    (OrderFilter.all, 'All'),
    (OrderFilter.orderFailed, 'Order Failed'),
    (OrderFilter.processing, 'Processing'),
    (OrderFilter.successful, 'Successful'),
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selected == OrderFilter.all) return _allOrders;
    return _allOrders.where((o) => o['status'] == _selected).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final orders = _filtered;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/app_logo.png',
          height: 34,
          errorBuilder: (_, _, _) => Text(
            'Eternal\nShine',
            textAlign: TextAlign.center,
            style: tt.titleSmall?.copyWith(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ),
        actions: [
          NotificationIconButton(count: 4),
          IconButton(
            icon: const Icon(Icons.search_outlined),
            color: AppColors.secondary,
            onPressed: () => Navigator.pushNamed(context, AppRouter.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Page title ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
            child: Text(
              'My Order',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontSize: 20,
              ),
            ),
          ),

          // ── Pill filter chips ─────────────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _tabs.map((tab) {
                final isSelected = _selected == tab.$1;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selected = tab.$1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : const Color(0xFFD6D6D6),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        tab.$2,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          // ── Order list / empty state ──────────────────────────────────────
          Expanded(
            child: orders.isEmpty
                ? const EmptyOrderState()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: orders.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => OrderCard(order: orders[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
