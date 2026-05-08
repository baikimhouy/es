import 'package:flutter/material.dart';

class RelatedProduct {
  const RelatedProduct({
    required this.brand,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imagePath,
    this.imageAlignment = Alignment.center,
  });

  final String brand;
  final String name;
  final String subtitle;
  final double price;
  final double rating;
  final int reviewCount;
  final String imagePath;
  final Alignment imageAlignment;
}
