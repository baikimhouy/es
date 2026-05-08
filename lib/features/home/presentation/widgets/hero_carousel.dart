

import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
class _Slide {
  final String asset;
  final String headline;
  final String sub;
  const _Slide(this.asset, this.headline, this.sub);
}

const _kSlides = [
  _Slide('assets/images/carousel.png', 'Your skin, your glow',   'Shop the latest serums'),
  _Slide('assets/images/carousel2.JPG', 'Summer essentials',       'SPF picks for every type'),
  _Slide('assets/images/img.png', 'New arrivals',            'Fresh drops this week'),
];

class HeroCarousel extends StatefulWidget {
  /// Height of the carousel. Defaults to 200.
  final double height;

  /// How long each slide stays visible before advancing.
  final Duration interval;

  const HeroCarousel({
    super.key,
    this.height = 300,
    this.interval = const Duration(seconds: 4),
  });

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _pageCtrl;
  late Timer _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    // Start at a large offset so we can scroll left on the first slide too
    _pageCtrl = PageController(initialPage: _kSlides.length * 500);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, (_) => _advance());
  }

  void _advance() {
    if (!mounted) return;
    _pageCtrl.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeInOut,
    );
  }

  int _realIndex(int page) => page % _kSlides.length;

  @override
  void dispose() {
    _timer.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: Stack(
        children: [

          // ── Slides ──────────────────────────────────────────────────────
          PageView.builder(
            controller: _pageCtrl,
            onPageChanged: (p) =>
                setState(() => _current = _realIndex(p)),
            itemBuilder: (_, page) {
              final slide = _kSlides[_realIndex(page)];
              return _SlideItem(slide: slide);
            },
          ),

          // ── Dot indicator ────────────────────────────────────────────────
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_kSlides.length, (i) {
                final active = i == _current;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width:  active ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primary
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),

        ],
      ),
    );
  }
}

// ── Single slide ──────────────────────────────────────────────────────────────
class _SlideItem extends StatelessWidget {
  final _Slide slide;
  const _SlideItem({required this.slide});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Image.asset(
      slide.asset,
      width: double.infinity,
      fit: BoxFit.cover,
      // Fallback banner shown when the asset file is missing
      errorBuilder: (_, _, _) => ColoredBox(
        color: AppColors.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.spa_outlined,
                  size: 40, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(
                slide.headline,
                style: tt.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                slide.sub,
                style: tt.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}