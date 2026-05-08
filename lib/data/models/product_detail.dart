import 'package:flutter/material.dart';

import 'product_review.dart';
import 'related_product.dart';

class ProductColorOption {
  const ProductColorOption({
    required this.label,
    required this.value,
    required this.assetPath,
  });

  final String label;
  final Color value;
  final String assetPath;
}

class ProductGalleryImage {
  const ProductGalleryImage({
    required this.assetPath,
    required this.title,
    required this.subtitle,
    this.alignment = Alignment.center,
  });

  final String assetPath;
  final String title;
  final String subtitle;
  final Alignment alignment;
}

class ProductDetail {
  const ProductDetail({
    required this.brand,
    required this.name,
    required this.originalPrice,
    required this.salePrice,
    required this.discountPercent,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.howToUse,
    required this.keyIngredients,
    required this.galleryImages,
    required this.colorOptions,
    required this.relatedProducts,
    required this.reviews,
  });

  final String brand;
  final String name;
  final double originalPrice;
  final double salePrice;
  final int discountPercent;
  final double rating;
  final int reviewCount;
  final List<String> description;
  final String howToUse;
  final String keyIngredients;
  final List<ProductGalleryImage> galleryImages;
  final List<ProductColorOption> colorOptions;
  final List<RelatedProduct> relatedProducts;
  final List<ProductReview> reviews;
}
