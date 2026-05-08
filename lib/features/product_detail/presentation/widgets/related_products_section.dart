import 'package:flutter/material.dart';

import '../../../../data/models/related_product.dart';
import 'product_card.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key, required this.products});

  final List<RelatedProduct> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'You may also like',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 450,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
