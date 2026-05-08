import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
        primaryColor: AppColors.primary,
      ),
      home: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCategory = 'Hand Cream';
  String _selectedBrand = '';
  String _selectedProductType = '';

  // Added: Controller to track what the user types in search
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All', 'Hand Cream', 'Oral Care', 'Body Care', 'Deodorant',
    'Toothpaste', 'Perfume', 'Contour & Highlighter', 'Eyes Cream',
    'Cleansing', 'Eye Brow'
  ];

  // Logic to determine the header text based on Search or Filter
  String get _displayTitle {
    if (_searchController.text.toLowerCase() == 'sunscreen') {
      return 'Sunscreen';
    }
    if (_selectedBrand.isNotEmpty && _selectedProductType.isNotEmpty) {
      return '$_selectedBrand + $_selectedProductType';
    }
    return _selectedCategory;
  }

  // Updated: Logic to return images based on Search Text or Filters
  List<String> get _currentImages {
    // 1. Check Search Bar first (Priority for Sunscreen search)
    if (_searchController.text.toLowerCase() == 'sunscreen') {
      return [
        'assets/images/sunscreen1.png',
        'assets/images/sunscreen2.png',
        'assets/images/sunscreen3.png',
        'assets/images/sunscreen4.png',
      ];
    }

    // 2. Check Filter selections (Round Lab + Toner)
    if (_selectedBrand == 'Round Lab' && _selectedProductType == 'Toner') {
      return [
        'assets/images/roundlap1.png',
        'assets/images/roundlap2.png',
        'assets/images/roundlap3.png',
        'assets/images/roundlap4.png',
      ];
    }

    // 3. Default Category chips
    if (_selectedCategory == 'All') {
      return [
        'assets/images/all1.png',
        'assets/images/all2.png',
        'assets/images/all3.png',
        'assets/images/all4.png',
      ];
    } else {
      return [
        'assets/images/Handcream1.png',
        'assets/images/handcream2.png',
        'assets/images/handcream3.png',
        'assets/images/handcream4.png',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 20.0, bottom: 16.0),
                      child: Text(
                        'Suggest for you',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    _buildCategoryChips(),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 28.0, bottom: 16.0),
                      child: Text(
                        _displayTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    _buildProductGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Check if there is a page to go back to
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                // Optional: Handle what happens if there is no back page
              }
            },
            child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
                size: 20
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController, // Linked to logic
                onChanged: (value) => setState(() {}), // Refresh UI on type
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                  prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _showMainFilterSheet(context),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.tune, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 12.0,
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
                _selectedBrand = '';
                _selectedProductType = '';
                _searchController.clear(); // Clear search when chip is tapped
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductGrid() {
    final images = _currentImages;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) => _buildDummyProductCard(images[index]),
    );
  }

  Widget _buildDummyProductCard(String imagePath) {
    // Determine the Brand Name to show on the card based on the image
    String brandName = 'MARMAR;D';
    if (imagePath.contains('roundlap') || imagePath.contains('sunscreen')) {
      brandName = 'ROUND LAB';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: AppColors.secondary, size: 48),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          brandName,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 4),
        const Text(
          'Product Description Text',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Text(
              '02%',
              style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(width: 6),
            Text(
              '7.50USD',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          '29.40USD',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Row(
              children: List.generate(
                  4,
                      (index) => const Icon(Icons.star, size: 12, color: AppColors.star)
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '(2)',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  // (Keeping your _showMainFilterSheet, _buildFilterRow, and _showSelectionSheet methods the same as previous)
  void _showMainFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const Text(
                    'Filter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Filter by',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              _buildFilterRow(context, _selectedBrand.isEmpty ? 'Brand' : _selectedBrand, () {
                Navigator.pop(context);
                _showSelectionSheet(context, 'Brand', ['COSRX', 'Innisfree', 'Etude House', 'Some By Mi', 'Round Lab', 'Beauty of Joseon', 'SK-II', 'CeraVe', 'The Ordinary']);
              }),
              const SizedBox(height: 12),
              _buildFilterRow(context, _selectedProductType.isEmpty ? 'Product' : _selectedProductType, () {
                Navigator.pop(context);
                _showSelectionSheet(context, 'Product', ['Cleanser', 'Toner', 'Serum', 'Essence', 'Moisturizer', 'Sunscreen', 'Face Mask', 'Eye Cream', 'Lip Care']);
              }),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    _searchController.clear(); // Clear search when applying filters
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Find',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterRow(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  // Only the _showSelectionSheet method needs fixing.
// Replace your existing _showSelectionSheet with this version:

void _showSelectionSheet(BuildContext context, String title, List<String> items) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setModalState) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B2B2B)),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final item = items[index];
                        final isCurrentlySelected = title == 'Brand'
                            ? _selectedBrand == item
                            : _selectedProductType == item;
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFCFD),
                            border: Border.all(color: const Color(0xFFE9DCE1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CheckboxListTile(
                            title: Text(item,
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2B2B2B))),
                            value: isCurrentlySelected,
                            onChanged: (bool? value) {
                              setModalState(() {
                                setState(() {
                                  if (title == 'Brand') {
                                    _selectedBrand = item;
                                  } else {
                                    _selectedProductType = item;
                                  }
                                });
                              });
                            },
                            controlAffinity:
                                ListTileControlAffinity.trailing,
                            activeColor: const Color(0xFFFF79A2),
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            side: const BorderSide(
                                color: Color(0xFFE9DCE1)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFFE9DCE1)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              setState(() {
                                if (title == 'Brand') {
                                  _selectedBrand = '';
                                } else {
                                  _selectedProductType = '';
                                }
                              });
                              Navigator.pop(ctx);
                            },
                            child: const Text('Clear',
                                style: TextStyle(
                                    color: Color(0xFF2B2B2B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF79A2),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Confirm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  ).then((_) {
    // ✅ Fixed: guard context use after async .then()
    if (!context.mounted) return;
    _showMainFilterSheet(context);
  });
}
}