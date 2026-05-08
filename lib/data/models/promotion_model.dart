import '../../../data/models/product_model.dart';

class PromotionModel {
  final String id;
  final String title;
  final String posterUrl;
  final List<ProductModel> products;

  const PromotionModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.products,
  });
}