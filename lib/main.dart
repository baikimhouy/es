// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/order_page/presentation/pages/order_page.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/demo/demo_product_detail.dart';
import 'features/cart/presentation/page/cart.dart';
import 'features/cart/presentation/page/payment.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/home/presentation/pages/category_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/sign_up_page.dart';
import 'features/inbox/presentation/pages/inbox_page.dart';
import 'features/product_detail/presentation/pages/product_detail_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/ui_search/search_page.dart';
import 'features/ui_search/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eternal Shine',
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.splash,
      routes: {
        AppRouter.splash: (_) => const SplashScreen(),
        AppRouter.login: (_) => const LoginPage(),
        AppRouter.signUp: (_) => const SignUpPage(),
        AppRouter.home: (_) => const HomeScreen(),
        AppRouter.category: (_) => const CategoryPage(),
         AppRouter.inbox: (_) => const InboxScreen(),
        AppRouter.cart: (_) => const CartScreen(),
        AppRouter.payment: (_) => const PaymentPage(),

        AppRouter.productDetail: (_) =>
            ProductDetailPage(product: DemoProductDetail.product),

        // Uncomment as screens are finished:
         AppRouter.order:   (_) => const OrderPage(),
         AppRouter.profile: (_) => const ProfilePage(),
        AppRouter.search:  (_) => const SearchScreen(),
      },
    );
  }
}
