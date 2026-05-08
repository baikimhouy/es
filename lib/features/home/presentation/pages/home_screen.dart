import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/home/presentation/pages/notification_screen.dart';
import 'package:flutter_product_detail_app/features/inbox/presentation/pages/inbox_page.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_product_detail_app/features/ui_search/search_page.dart';

import '../../../../data/models/product_model.dart';
import '../../../../data/constants/promotion_constants.dart';
import '../../../cart/presentation/page/cart.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../widgets/home_category_grid.dart';
import '../widgets/section_header.dart';
import '../widgets/horizontal_product_list.dart';
import '../widgets/brand_chip.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/promotion_poster_card.dart';
import '../../../order_page/presentation/pages/order_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final String _skinType = 'normal';

  List<ProductModel> get _recommended =>
      sampleProducts.where((p) => p.suitableFor.contains(_skinType)).toList();

  void _onNavTap(int index) => setState(() => _navIndex = index);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: IndexedStack(
        index: _navIndex,
        children: [
          _buildHomePage(tt),
          const CartScreen(),
          const OrderPage(),
          const InboxScreen(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildHomePage(TextTheme tt) {
    final double systemBottom = MediaQuery.of(context).viewPadding.bottom;
    final double scrollBottomPadding = 72.0 + systemBottom + 12.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        centerTitle: true,
        title: Image.asset(
          'assets/images/app_logo.png',
          height: 34,
          errorBuilder: (_, _, _) => Text(
            'GlowUp',
            style: tt.titleLarge?.copyWith(color: AppColors.primary),
          ),
        ),
        actions: [
          NotificationIconButton(count: 4),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: scrollBottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeroCarousel(height: 200),
            const HomeCategoryGrid(),

            // ── Current Promotion ──────────────────────────────────────
            SectionHeader(title: 'Current Promotion'),
            _buildPromotionGrid(),

            // ── Best Deal ──────────────────────────────────────────────
            SectionHeader(title: 'Best Deal', onSeeAll: () {}),
            HorizontalProductList(
              products: sampleProducts,
              offset: 2,
              listHeight: 320,
            ),

            SectionHeader(title: 'Trending Now', onSeeAll: () {}),
            _recommended.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'No trending products for your skin type.',
                      style: tt.bodyMedium,
                    ),
                  )
                : HorizontalProductList(
                    products: _recommended,
                    listHeight: 320,
                  ),

            SectionHeader(title: 'Popular Brand'),
            BrandMarquee(images: brandList, speed: 55),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Column of Rows — takes exactly the content height, no phantom gap
  Widget _buildPromotionGrid() {
    const double gap = 8.0;
    final promos = samplePromotions;
    final List<Widget> rows = [];

    for (int i = 0; i < promos.length; i += 2) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: PromotionPosterCard(promotion: promos[i])),
            const SizedBox(width: gap),
            Expanded(
              child: i + 1 < promos.length
                  ? PromotionPosterCard(promotion: promos[i + 1])
                  : const SizedBox(),
            ),
          ],
        ),
      );
      if (i + 2 < promos.length) rows.add(const SizedBox(height: gap));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: rows),
    );
  }
}




