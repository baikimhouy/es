import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_detail.dart';
import '../../../../data/models/product_review.dart';
import '../pages/product_review_page.dart';
import '../widgets/center_title_top_bar.dart';
import '../widgets/color_selection_sheet.dart';
import '../widgets/product_gallery.dart';
import '../widgets/product_information_section.dart';
import '../widgets/product_promo_banner.dart';
import '../widgets/product_summary_section.dart';
import '../widgets/product_tab_bar.dart';
import '../widgets/related_products_section.dart';
import '../widgets/review_card.dart';
import '../widgets/review_summary_card.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductDetail product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _detailSectionKey = GlobalKey();
  final GlobalKey _reviewSectionKey = GlobalKey();
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _cartIconKey = GlobalKey();

  ProductPageSection _selectedSection = ProductPageSection.detail;
  late final AnimationController _cartAnimationController;
  Offset? _flightStart;
  Offset? _flightEnd;
  String? _flyingAssetPath;
  int _cartItemCount = 0;
  int _pendingCartQuantity = 0;
  List<ProductReview>? _reviews;

  List<ProductReview> get _reviewItems =>
      _reviews ??= List<ProductReview>.from(widget.product.reviews);

  @override
  void initState() {
    super.initState();
    _reviewItems;
    _cartAnimationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 650),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _cartItemCount += _pendingCartQuantity;
              _pendingCartQuantity = 0;
              _flyingAssetPath = null;
              _flightStart = null;
              _flightEnd = null;
            });
            _cartAnimationController.reset();
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cartAnimationController.dispose();
    super.dispose();
  }

  Future<void> _jumpToSection(ProductPageSection section) async {
    setState(() => _selectedSection = section);
    final key = section == ProductPageSection.detail
        ? _detailSectionKey
        : _reviewSectionKey;

    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _handleAddToCart(ColorSelectionResult result) async {
    final stackContext = _stackKey.currentContext;
    final cartContext = _cartIconKey.currentContext;

    if (stackContext == null || cartContext == null) {
      setState(() => _cartItemCount += result.quantity);
      return;
    }

    final stackBox = stackContext.findRenderObject() as RenderBox;
    final cartBox = cartContext.findRenderObject() as RenderBox;

    final cartCenter = stackBox.globalToLocal(
      cartBox.localToGlobal(cartBox.size.center(Offset.zero)),
    );

    final startGlobal = result.startGlobalOffset == Offset.zero
        ? cartBox.localToGlobal(Offset.zero)
        : result.startGlobalOffset;

    final startLocal = stackBox.globalToLocal(startGlobal);

    setState(() {
      _flyingAssetPath = result.selectedOption.assetPath;
      _flightStart = startLocal;
      _flightEnd = cartCenter;
      _pendingCartQuantity = result.quantity;
    });

    await _cartAnimationController.forward();
  }

  double get _displayRating {
    if (_reviewItems.isEmpty) {
      return widget.product.rating;
    }

    final total = _reviewItems.fold<double>(
      0,
      (sum, review) => sum + review.rating,
    );

    return total / _reviewItems.length;
  }

  Future<void> _openWriteReviewPage() async {
    final newReview = await Navigator.of(context).push<ProductReview>(
      MaterialPageRoute<ProductReview>(
        builder: (_) => const ProductReviewPage(),
      ),
    );

    if (newReview == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _reviewItems.insert(0, newReview);
      _selectedSection = ProductPageSection.review;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reviewContext = _reviewSectionKey.currentContext;
      if (reviewContext != null) {
        Scrollable.ensureVisible(
          reviewContext,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final reviews = _reviewItems;
    final reviewCount = reviews.length;

    return Scaffold(
      body: Stack(
        key: _stackKey,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFFEFF), AppColors.background],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  CenterTitleTopBar(
                    logoAssetPath: 'assets/images/app_logo.png',
                    trailing: _CartIconBadge(
                      count: _cartItemCount,
                      iconKey: _cartIconKey,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductGallery(images: product.galleryImages),
                          const SizedBox(height: 28),
                          ProductSummarySection(
                            product: product,
                            displayRating: _displayRating,
                            displayReviewCount: reviewCount,
                            onAddToCart: _handleAddToCart,
                          ),
                          const SizedBox(height: 30),
                          ProductTabBar(
                            selectedSection: _selectedSection,
                            reviewCount: reviewCount,
                            onSectionSelected: _jumpToSection,
                          ),
                          Container(
                            key: _detailSectionKey,
                            margin: const EdgeInsets.only(top: 6),
                            child: ProductInformationSection(product: product),
                          ),
                          const ProductPromoBanner(),
                          RelatedProductsSection(
                            products: product.relatedProducts,
                          ),
                          Container(
                            key: _reviewSectionKey,
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                            child: Text(
                              'Review($reviewCount)',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(fontSize: 24),
                            ),
                          ),
                          ReviewSummaryCard(
                            rating: _displayRating,
                            reviewCount: reviewCount,
                            onWriteReview: _openWriteReviewPage,
                          ),
                          ...reviews.map(
                            (review) => ReviewCard(review: review),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_flyingAssetPath != null &&
              _flightStart != null &&
              _flightEnd != null)
            AnimatedBuilder(
              animation: _cartAnimationController,
              builder: (context, child) {
                final animationValue = Curves.easeInOutCubic.transform(
                  _cartAnimationController.value,
                );
                final position = Offset.lerp(
                  _flightStart,
                  _flightEnd,
                  animationValue,
                )!;
                final lift = 70 * (1 - (2 * animationValue - 1).abs());
                final size = lerpDouble(56, 22, animationValue)!;

                return Positioned(
                  left: position.dx - (size / 2),
                  top: position.dy - (size / 2) - lift,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 1 - (_cartAnimationController.value * 0.2),
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Image.asset(
                          _flyingAssetPath!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _CartIconBadge extends StatelessWidget {
  const _CartIconBadge({required this.count, required this.iconKey});

  final int count;
  final GlobalKey iconKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.shopping_cart_outlined,
            key: iconKey,
            color: AppColors.textSecondary,
          ),
        ),
        if (count > 0)
          Positioned(
            right: 0,
            top: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(999),
              ),
              constraints: const BoxConstraints(minWidth: 18),
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
