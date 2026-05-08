class ProductReview {
  const ProductReview({
    required this.author,
    required this.dateLabel,
    required this.rating,
    required this.comment,
    required this.tags,
    required this.avatarText,
    this.assetPath,
    this.fileImagePath,
    this.profileAssetPath,
  });

  final String author;
  final String dateLabel;
  final double rating;
  final String comment;
  final List<String> tags;
  final String avatarText;
  final String? assetPath;
  final String? fileImagePath;
  final String? profileAssetPath;
}
