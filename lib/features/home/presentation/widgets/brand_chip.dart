import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// ─── Data model ───────────────────────────────────────────────
class BrandItem {
  final String imageAsset;
  const BrandItem({required this.imageAsset});
}

// ─── All your brand images ─────────────────────────────────────
final List<BrandItem> brandList = [
  BrandItem(imageAsset: 'assets/images/id_3IO8q9s_1773221773757.png'),
  BrandItem(imageAsset: 'assets/images/id-akJ-BcB_1773221903190.png'),
  BrandItem(imageAsset: 'assets/images/id6pAALSwC_logos.png'),
  BrandItem(imageAsset: 'assets/images/idHqNo7HMR_logos.png'),
  BrandItem(imageAsset: 'assets/images/idJrC9la0L_logos.png'),
  BrandItem(imageAsset: 'assets/images/idkaLhinPg_logos.png'),
  BrandItem(imageAsset: 'assets/images/idMYSZXVu8_logos.png'),
  BrandItem(imageAsset: 'assets/images/idoMf9oKn2_logos.png'),
  BrandItem(imageAsset: 'assets/images/idSYKWAB2W_logos.png'),
  BrandItem(imageAsset: 'assets/images/idX_dEWu3R_logos.png'),
  BrandItem(imageAsset: 'assets/images/idX2qQtj_D_1773221253897.png'),
  BrandItem(imageAsset: 'assets/images/idZLVB7rey_logos.png'),
];

// ─── Single chip ───────────────────────────────────────────────
class BrandChip extends StatelessWidget {
  final BrandItem brand;
  final VoidCallback? onTap;

  const BrandChip({super.key, required this.brand, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90, // ← fixed width so all chips are equal
        height: 52, // ← fixed height
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Image.asset(
          brand.imageAsset,
          fit: BoxFit.contain, // keeps logo proportions intact
        ),
      ),
    );
  }
}

// ─── Infinite looping marquee ──────────────────────────────────
class BrandMarquee extends StatefulWidget {
  final List<BrandItem> images;
  final double speed; // pixels per second

  const BrandMarquee({super.key, required this.images, this.speed = 55});

  @override
  State<BrandMarquee> createState() => _BrandMarqueeState();
}

class _BrandMarqueeState extends State<BrandMarquee>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final ScrollController _scrollController;
  double _singleRunWidth = 0;

  static const int _copies = 3;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoop());
  }

  void _startLoop() {
    if (!mounted) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    _singleRunWidth = maxScroll / (_copies - 1);

    final ms = ((_singleRunWidth / widget.speed) * 1000).round();
    _controller.duration = Duration(milliseconds: ms);

    _controller.addListener(() {
      if (!_scrollController.hasClients) return;
      _scrollController.jumpTo(_controller.value * _singleRunWidth);
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allimages = List.generate(
      _copies,
      (_) => widget.images,
    ).expand((b) => b).toList();

    return SizedBox(
      height: 52,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allimages.length,
        itemBuilder: (_, index) => BrandChip(brand: allimages[index]),
      ),
    );
  }
}
