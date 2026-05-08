import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';
import 'product_card.dart';

class HorizontalProductList extends StatelessWidget {
  final List<ProductModel> products;
  final int offset;
  final double listHeight;
  final double cardWidthFraction;
  final double cardWidthMin;
  final double cardWidthMax;

  const HorizontalProductList({
    super.key,
    required this.products,
    this.offset = 0,
    this.listHeight = 200,
    this.cardWidthFraction = 0.42,
    this.cardWidthMin = 145,
    this.cardWidthMax = 175,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth =
    (MediaQuery.of(context).size.width * cardWidthFraction)
        .clamp(cardWidthMin, cardWidthMax);

    return SizedBox(
      height: listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (_, i) {
          final product = products[(i + offset) % products.length];
          return SizedBox(
            width: cardWidth,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ProductCard(product: product),
            ),
          );
        },
      ),
    );
  }
}