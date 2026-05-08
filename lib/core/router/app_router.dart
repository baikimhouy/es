
// lib/core/router/app_router.dart
class AppRouter {
  AppRouter._();

  // ── Auth ──────────────────────────────────────────────────────────────
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/sign-up';

  // ── Main navigation ───────────────────────────────────────────────────
  static const String home = '/';
  static const String search = '/search';
  static const String cart = '/cart';
  static const String inbox = '/inbox';
  static const String profile = '/profile';

  // ── Product ───────────────────────────────────────────────────────────
  static const String productDetail = '/product-detail';
  static const String order = '/order';

  // ── Category ──────────────────────────────────────────────────────────
  static const String category = '/category';

  // ── Cart → Payment ────────────────────────────────────────────────────
  // Receives List<Map<String,dynamic>> as arguments from CartScreen:
  //   Navigator.pushNamed(context, AppRouter.payment, arguments: selectedItems)
  static const String payment = '/payment';
}
