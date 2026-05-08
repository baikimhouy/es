import '../models/promotion_model.dart';
import '../models/product_model.dart';

// Reuse your existing sampleProducts — import from product_model.dart
// Each promotion links to a filtered subset of products.
// Replace posterUrl values with your real asset/network poster images.

final List<PromotionModel> samplePromotions = [
  PromotionModel(
    id: 'promo_1',
    title: 'Skin1004 Brand Sale',
    posterUrl:
        'https://i.pinimg.com/1200x/89/1e/dc/891edc527a7b0bad5ce6220ef1823727.jpg',
    products: sampleProducts.take(4).toList(),
  ),
  PromotionModel(
    id: 'promo_2',
    title: 'Flash Sale',
    posterUrl:
        'https://i.pinimg.com/1200x/fd/aa/7f/fdaa7fe74da171cf69171ff7b9c9c132.jpg',
    products: sampleProducts.skip(2).take(4).toList(),
  ),
  PromotionModel(
    id: 'promo_3',
    title: 'Romand Make Up',
    posterUrl:
        'https://i.pinimg.com/1200x/d2/4c/b1/d24cb121be5e236c041fc71b4d24d69c.jpg',
    products: sampleProducts.skip(1).take(4).toList(),
  ),
  PromotionModel(
    id: 'promo_4',
    title: 'Restock & New Arrival',
    posterUrl:
        'https://i.pinimg.com/736x/c3/14/da/c314daeb45bf7d9d5852924ef791baba.jpg',
    products: sampleProducts.skip(3).take(4).toList(),
  ),
];
