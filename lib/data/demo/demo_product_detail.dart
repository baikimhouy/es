import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/product_detail.dart';
import '../models/product_review.dart';
import '../models/related_product.dart';

class DemoProductDetail {
  DemoProductDetail._();

  static const product = ProductDetail(
    brand: 'Eternal Shine',
    name: 'Ready to Wear Downy Cheek',
    originalPrice: 57,
    salePrice: 18.7,
    discountPercent: 25,
    rating: 4,
    reviewCount: 3,
    description: [
      'Creates vivid cheeks with a soft watercolor finish.',
      'Builds up smoothly without disturbing base makeup.',
      'Comfortable for everyday wear and easy touch-ups on the go.',
    ],
    howToUse:
        'Apply a small amount on the apples of your cheeks using fingers or a sponge, then blend diagonally for a lifted soft-focus look.',
    keyIngredients:
        'Hexyl Laurate, Cetyl Ethylhexanoate, Titanium Dioxide, Mica, Dimethicone, Caprylic/Capric Triglyceride and Hydrogenated Olive Oil Unsaponifiables.',
    galleryImages: [
      ProductGalleryImage(
        assetPath: 'assets/images/product_gallery_1.png',
        title: 'Product View',
        subtitle: 'Pack shot inspired by your provided reference',
        alignment: Alignment(0, -1),
      ),
      ProductGalleryImage(
        assetPath: 'assets/images/product_gallery_2.png',
        title: 'Editorial View',
        subtitle: 'Promo section focus with lifestyle framing',
        alignment: Alignment(0, 0.1),
      ),
      ProductGalleryImage(
        assetPath: 'assets/images/product_gallery_3.png',
        title: 'Review View',
        subtitle: 'Customer section preview for product trust',
        alignment: Alignment(0, 1),
      ),
    ],
    colorOptions: [
      ProductColorOption(
        label: 'Downy Rose',
        value: AppColors.primary,
        assetPath: 'assets/images/option1.png',
      ),
      ProductColorOption(
        label: 'Soft Apple',
        value: AppColors.secondary,
        assetPath: 'assets/images/option2.png',
      ),
      ProductColorOption(
        label: 'Bloom Fig',
        value: Color(0xFFF9C1C9),
        assetPath: 'assets/images/option3.png',
      ),
      ProductColorOption(
        label: 'Rosy Milk',
        value: Color(0xFFF5CDD8),
        assetPath: 'assets/images/option4.png',
      ),
    ],
    relatedProducts: [
      RelatedProduct(
        brand: 'AESTURA',
        name: 'Clarify Facial Mist',
        subtitle: 'Barrier hydration mist 80mL',
        price: 40,
        rating: 4.0,
        reviewCount: 38,
        imagePath: 'assets/images/product_1.png',
        imageAlignment: Alignment(0, -1),
      ),
      RelatedProduct(
        brand: 'AESTURA',
        name: 'Barrier Cream',
        subtitle: 'Daily soothing cream 80mL',
        price: 40,
        rating: 4.0,
        reviewCount: 38,
        imagePath: 'assets/images/product_1.png',
        imageAlignment: Alignment(0, 0.05),
      ),
      RelatedProduct(
        brand: 'AESTURA',
        name: 'Glow Ampoule',
        subtitle: 'Brightening serum 30mL',
        price: 40,
        rating: 4.0,
        reviewCount: 38,
        imagePath: 'assets/images/product_1.png',
        imageAlignment: Alignment(0, 1),
      ),
    ],
    reviews: [
      ProductReview(
        author: 'Moa Moa',
        dateLabel: '2026-04-05',
        rating: 4,
        comment:
            'I have been consistently impressed by the quality of this product. The color payoff feels balanced, soft, and flattering for daily makeup looks.',
        tags: ['Skin Tone Fair', 'Skin Type Oily', 'Skin Concern Acne'],
        avatarText: 'MM',
        profileAssetPath: 'assets/images/product_gallery_3.png',
      ),
      ProductReview(
        author: 'Missy Lee Cooper',
        dateLabel: '2026-04-05',
        rating: 4,
        comment:
            'I loved the shade of this product. It is easy to bring on the go, very pigmented, and the finish stays fresh for hours.',
        tags: ['Skin Tone Fair', 'Skin Type Oily', 'Skin Concern Acne'],
        avatarText: 'MC',
        assetPath: 'assets/images/review_product_1.png',
        profileAssetPath: 'assets/images/product_gallery_3.png',
      ),
      ProductReview(
        author: 'Paul',
        dateLabel: '2026-04-05',
        rating: 4,
        comment:
            'First time trying this blush and I picked the popular Downy Fig tone. It blends beautifully with a small sponge and works well in both spring and summer.',
        tags: ['Skin Tone Fair', 'Skin Type Oily', 'Skin Concern Acne'],
        avatarText: 'P',
      ),
    ],
  );
}
