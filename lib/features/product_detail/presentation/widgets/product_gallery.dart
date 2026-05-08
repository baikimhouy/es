import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_detail.dart';

class ProductGallery extends StatefulWidget {
  const ProductGallery({super.key, required this.images});

  final List<ProductGalleryImage> images;

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  final PageController _pageController = PageController(viewportFraction: 0.86);
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = widget.images;

    return Column(
      children: [
        SizedBox(
          height: 460,
          child: PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return AnimatedPadding(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 10,
                  right: 10,
                  top: _currentIndex == index ? 0 : 24,
                  bottom: _currentIndex == index ? 0 : 14,
                ),
                child: _GallerySlide(
                  image: slides[index],
                  pageNumber: index + 1,
                  pageCount: slides.length,
                  isActive: _currentIndex == index,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(slides.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isActive ? 24 : 8,
              decoration: BoxDecoration(
                color: isActive ? AppColors.textPrimary : AppColors.border,
                borderRadius: BorderRadius.circular(99),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 70,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: slides.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final image = slides[index];
              final isSelected = index == _currentIndex;

              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 70,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.accent : AppColors.border,
                      width: isSelected ? 1.8 : 1,
                    ),
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(0x1FFF2160),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      image.assetPath,
                      fit: BoxFit.cover,
                      alignment: image.alignment,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GallerySlide extends StatelessWidget {
  const _GallerySlide({
    required this.image,
    required this.pageNumber,
    required this.pageCount,
    required this.isActive,
  });

  final ProductGalleryImage image;
  final int pageNumber;
  final int pageCount;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              image.assetPath,
              fit: BoxFit.cover,
              alignment: image.alignment,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.08),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.45),
                ],
                stops: const [0, 0.42, 1],
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.88),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '$pageNumber / $pageCount',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 18,
          //   right: 18,
          //   child: Container(
          //     width: 42,
          //     height: 42,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: Colors.white.withValues(alpha: 0.88),
          //       shape: BoxShape.circle,
          //     ),
          //     child: Icon(
          //       isActive
          //           ? Icons.favorite_rounded
          //           : Icons.favorite_border_rounded,
          //       color: AppColors.accent,
          //       size: 22,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: 22,
          //   bottom: 108,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          //     decoration: BoxDecoration(
          //       gradient: const LinearGradient(
          //         colors: [AppColors.secondary, AppColors.primary],
          //       ),
          //       borderRadius: BorderRadius.circular(999),
          //     ),
          //     child: Text(
          //       'Best Seller',
          //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: 22,
          //   right: 22,
          //   bottom: 22,
          //   child: Container(
          //     padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          //     decoration: BoxDecoration(
          //       color: Colors.white.withValues(alpha: 0.88),
          //       borderRadius: BorderRadius.circular(24),
          //     ),
          //     child: Row(
          //       children: [
          //         Container(
          //           width: 44,
          //           height: 44,
          //           decoration: BoxDecoration(
          //             gradient: const LinearGradient(
          //               colors: [AppColors.secondary, AppColors.primary],
          //             ),
          //             borderRadius: BorderRadius.circular(14),
          //           ),
          //           child: const Icon(
          //             Icons.auto_awesome_rounded,
          //             color: Colors.white,
          //           ),
          //         ),
          //         const SizedBox(width: 14),
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Text(
          //                 image.title,
          //                 style: Theme.of(context).textTheme.titleMedium
          //                     ?.copyWith(fontWeight: FontWeight.w700),
          //               ),
          //               const SizedBox(height: 4),
          //               Text(
          //                 image.subtitle,
          //                 style: Theme.of(context).textTheme.bodyMedium
          //                     ?.copyWith(color: AppColors.textSecondary),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
