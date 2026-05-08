// lib/data/models/product_model.dart
class ProductModel {
  final String id;
  final String name;
  final String type; // e.g. 'Cleanser', 'Serum', 'Foundation'
  final String description;
  final double price;
  final List<String> suitableFor;
  final String? imageUrl;
  final double rating;
  final int reviewCount;

  /// Free-form tags used by CategoryPage filters.
  /// Examples: ['New', 'Top Rated'], ['Collagen'], ['Face'], ['Flash Sale']
  final List<String> tags;

  const ProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.suitableFor,
    this.imageUrl,
    this.rating = 0,
    this.reviewCount = 0,
    this.tags = const [],
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Full catalogue — covers every category and filter chip
// ─────────────────────────────────────────────────────────────────────────────
final List<ProductModel> sampleProducts = [
  // ── Skincare ──────────────────────────────────────────────────────────────
  ProductModel(
    id: '1',
    name: 'Gentle Foam Cleanser',
    type: 'Cleanser',
    description:
        'Removes dirt without stripping moisture from the skin barrier.',
    price: 12.99,
    suitableFor: ['oily', 'combination', 'normal'],
    imageUrl:
        'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=400&fit=crop',
    rating: 4.5,
    reviewCount: 128,
    tags: ['Best Seller', 'Skincare'],
  ),
  ProductModel(
    id: '2',
    name: 'Hyaluronic Acid Serum',
    type: 'Serum',
    description: 'Deep hydration with 2% hyaluronic acid for plump dewy skin.',
    price: 24.99,
    suitableFor: ['dry', 'normal', 'combination'],
    imageUrl:
        'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400&fit=crop',
    rating: 4.8,
    reviewCount: 214,
    tags: ['Top Rated', 'New', 'Skincare'],
  ),
  ProductModel(
    id: '3',
    name: 'SPF 50 Sunscreen',
    type: 'Sunscreen',
    description:
        'Lightweight sunscreen with broad spectrum UVA/UVB protection.',
    price: 18.99,
    suitableFor: ['oily', 'dry', 'combination', 'normal', 'sensitive'],
    imageUrl:
        'https://images.unsplash.com/photo-1556227834-09f1de7a7d14?w=400&fit=crop',
    rating: 4.6,
    reviewCount: 97,
    tags: ['Skincare', 'Best Seller'],
  ),
  ProductModel(
    id: '4',
    name: 'Niacinamide Toner',
    type: 'Toner',
    description: 'Balances skin tone and minimises pores with 10% niacinamide.',
    price: 15.99,
    suitableFor: ['oily', 'combination'],
    imageUrl:
        'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400&fit=crop',
    rating: 4.3,
    reviewCount: 76,
    tags: ['Skincare'],
  ),
  ProductModel(
    id: '5',
    name: 'Ceramide Moisturiser',
    type: 'Moisturiser',
    description: 'Barrier-repairing cream with ceramides and peptides.',
    price: 21.99,
    suitableFor: ['dry', 'sensitive'],
    imageUrl:
        'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=400&fit=crop',
    rating: 4.7,
    reviewCount: 163,
    tags: ['Top Rated', 'Skincare'],
  ),
  ProductModel(
    id: '6',
    name: 'Rose Water Toner',
    type: 'Toner',
    description: 'Soothing toner with rose water to calm irritated skin.',
    price: 9.99,
    suitableFor: ['sensitive', 'normal', 'dry'],
    imageUrl:
        'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400&fit=crop',
    rating: 4.2,
    reviewCount: 54,
    tags: ['Skincare', 'New'],
  ),
  ProductModel(
    id: '7',
    name: 'Vitamin C Brightening Serum',
    type: 'Serum',
    description: 'Fades dark spots and boosts radiance with 15% vitamin C.',
    price: 29.99,
    suitableFor: ['normal', 'combination', 'dry'],
    imageUrl:
        'https://images.unsplash.com/photo-1617897903246-719242758050?w=400&fit=crop',
    rating: 4.9,
    reviewCount: 302,
    tags: ['Top Rated', 'Skincare', 'Flash Sale'],
  ),
  ProductModel(
    id: '8',
    name: 'AHA BHA Exfoliant',
    type: 'Cleanser',
    description: 'Gently unclogs pores and resurfaces skin with AHA/BHA acids.',
    price: 22.99,
    suitableFor: ['oily', 'combination'],
    imageUrl:
        'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=400&fit=crop',
    rating: 4.4,
    reviewCount: 115,
    tags: ['Skincare', 'New'],
  ),

  // ── Make Up ───────────────────────────────────────────────────────────────
  ProductModel(
    id: '9',
    name: 'Dewy Finish Foundation',
    type: 'Foundation',
    description: 'Buildable coverage with a natural skin-like dewy finish.',
    price: 32.00,
    suitableFor: ['normal', 'dry'],
    imageUrl:
        'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=400&fit=crop',
    rating: 4.6,
    reviewCount: 221,
    tags: ['Make Up', 'Best Seller'],
  ),
  ProductModel(
    id: '10',
    name: 'Velvet Matte Lipstick',
    type: 'Lip',
    description: 'Long-wearing matte formula with comfortable all-day wear.',
    price: 14.50,
    suitableFor: ['normal', 'combination', 'oily'],
    imageUrl:
        'https://images.unsplash.com/photo-1586495777744-4e6fca05d139?w=400&fit=crop',
    rating: 4.5,
    reviewCount: 189,
    tags: ['Make Up', 'New'],
  ),
  ProductModel(
    id: '11',
    name: 'Volumising Mascara',
    type: 'Eye',
    description: 'Adds dramatic volume and length without clumping.',
    price: 18.00,
    suitableFor: ['normal', 'sensitive'],
    imageUrl:
        'https://images.unsplash.com/photo-1631214499006-d2b3c5ceaca5?w=400&fit=crop',
    rating: 4.3,
    reviewCount: 144,
    tags: ['Make Up'],
  ),
  ProductModel(
    id: '12',
    name: 'Satin Blush Duo',
    type: 'Blush',
    description: 'Buildable satin blush for a natural flushed cheek look.',
    price: 22.00,
    suitableFor: ['normal', 'dry', 'combination'],
    imageUrl:
        'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=400&fit=crop',
    rating: 4.4,
    reviewCount: 98,
    tags: ['Make Up', 'Top Rated'],
  ),
  ProductModel(
    id: '13',
    name: 'Pore-Blurring Primer',
    type: 'Primer',
    description: 'Smooths texture and extends makeup wear all day.',
    price: 26.00,
    suitableFor: ['oily', 'combination'],
    imageUrl:
        'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?w=400&fit=crop',
    rating: 4.7,
    reviewCount: 167,
    tags: ['Make Up', 'Best Seller'],
  ),

  // ── Supplement ────────────────────────────────────────────────────────────
  ProductModel(
    id: '14',
    name: 'Marine Collagen Peptides',
    type: 'Collagen',
    description:
        'Hydrolysed marine collagen for firmer skin and stronger nails.',
    price: 38.00,
    suitableFor: ['normal', 'dry', 'sensitive'],
    imageUrl:
        'https://images.unsplash.com/photo-1559181567-c3190ca9d222?w=400&fit=crop',
    rating: 4.8,
    reviewCount: 275,
    tags: ['Supplement', 'Top Rated'],
  ),
  ProductModel(
    id: '15',
    name: 'Glow Vitamins C + E',
    type: 'Vitamins',
    description:
        'Daily antioxidant blend with vitamins C and E for radiant skin.',
    price: 24.00,
    suitableFor: ['normal', 'combination'],
    imageUrl:
        'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400&fit=crop',
    rating: 4.5,
    reviewCount: 132,
    tags: ['Supplement', 'New'],
  ),
  ProductModel(
    id: '16',
    name: 'Green Tea Antioxidant Capsules',
    type: 'Antioxidant',
    description: 'High-potency green tea extract to fight free radical damage.',
    price: 19.99,
    suitableFor: ['oily', 'combination', 'normal'],
    imageUrl:
        'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&fit=crop',
    rating: 4.2,
    reviewCount: 89,
    tags: ['Supplement'],
  ),
  ProductModel(
    id: '17',
    name: 'Detox Beauty Blend',
    type: 'Detox',
    description:
        'Supports skin clarity from within with chlorella and spirulina.',
    price: 29.00,
    suitableFor: ['oily', 'combination'],
    imageUrl:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&fit=crop',
    rating: 4.1,
    reviewCount: 61,
    tags: ['Supplement'],
  ),

  // ── Beauty Tools ──────────────────────────────────────────────────────────
  ProductModel(
    id: '18',
    name: 'Rose Quartz Gua Sha',
    type: 'Face',
    description: 'Sculpts and depuffs with traditional gua sha technique.',
    price: 16.00,
    suitableFor: ['normal', 'sensitive', 'dry'],
    imageUrl:
        'https://images.unsplash.com/photo-1625093952691-bb5c60e27e0b?w=400&fit=crop',
    rating: 4.6,
    reviewCount: 203,
    tags: ['Beauty Tools', 'Best Seller'],
  ),
  ProductModel(
    id: '19',
    name: 'Ionic Hair Dryer',
    type: 'Hair',
    description:
        'Reduces frizz with ionic technology for smooth salon results.',
    price: 59.99,
    suitableFor: ['normal'],
    imageUrl:
        'https://images.unsplash.com/photo-1522338140262-f46f5913618a?w=400&fit=crop',
    rating: 4.7,
    reviewCount: 318,
    tags: ['Beauty Tools', 'Top Rated'],
  ),
  ProductModel(
    id: '20',
    name: 'Dry Body Brush',
    type: 'Body',
    description:
        'Stimulates circulation and smooths skin with natural bristles.',
    price: 12.00,
    suitableFor: ['normal', 'dry'],
    imageUrl:
        'https://images.unsplash.com/photo-1570554886111-e80fcca6a029?w=400&fit=crop',
    rating: 4.3,
    reviewCount: 77,
    tags: ['Beauty Tools'],
  ),
  ProductModel(
    id: '21',
    name: 'UV Gel Nail Kit',
    type: 'Nails',
    description: 'Complete at-home gel nail system for salon-quality results.',
    price: 34.99,
    suitableFor: ['normal'],
    imageUrl:
        'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=400&fit=crop',
    rating: 4.4,
    reviewCount: 142,
    tags: ['Beauty Tools', 'New'],
  ),
];
