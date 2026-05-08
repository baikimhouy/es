import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/notification_model.dart';
import '../../../../data/constants/notification_constants.dart';
import '../widgets/notification_cart.dart';
import 'promotion_page.dart';

// Pass the calling context so we can navigate after the sheet is popped
void showNotificationSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => NotificationSheet(parentContext: context), // ← changed
  );
}

class NotificationSheet extends StatelessWidget {
  final BuildContext parentContext; // ← new

  const NotificationSheet({super.key, required this.parentContext});

  // Close the sheet, then push PromotionPage using the parent context
  void _goToPromotion() {
    Navigator.pop(parentContext);
    Navigator.push(
      parentContext,
      MaterialPageRoute(builder: (_) => const PromotionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // ── Drag Handle ───────────────────────────────────────────────
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // ── Header ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── List ──────────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _getGrouped().length,
              itemBuilder: (context, index) {
                final group = _getGrouped()[index];
                return _NotificationGroup(
                  group: group,
                  onCardTap: _goToPromotion, // ← pass tap handler down
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getGrouped() {
    final Map<String, List<NotificationModel>> grouped = {};
    for (var n in sampleNotifications) {
      final key = _formatDate(n.date);
      grouped.putIfAbsent(key, () => []).add(n);
    }
    return grouped.entries
        .map((e) => {'date': e.key, 'notifications': e.value})
        .toList();
  }

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    const m = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${m[date.month - 1]} ${date.year}';
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Grouped Section
// ══════════════════════════════════════════════════════════════════════════════
class _NotificationGroup extends StatelessWidget {
  final Map<String, dynamic> group;
  final VoidCallback onCardTap; // ← new

  const _NotificationGroup({
    required this.group,
    required this.onCardTap, // ← new
  });

  @override
  Widget build(BuildContext context) {
    final List<NotificationModel> notifications = group['notifications'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text(
            group['date'],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.3,
            ),
          ),
        ),
        // Wrap each card with a tap → go to PromotionPage
        ...notifications.map(
          (n) => GestureDetector(
            onTap: onCardTap,
            child: NotificationCard(notification: n),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Notification Icon Button (AppBar)
// ══════════════════════════════════════════════════════════════════════════════
class NotificationIconButton extends StatelessWidget {
  final int count;
  final Color? iconColor;

  const NotificationIconButton({super.key, this.count = 0, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined),
          color: iconColor ?? AppColors.secondary,
          onPressed: () => showNotificationSheet(context),
        ),
        if (count > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
