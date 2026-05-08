import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_review.dart';
import '../widgets/center_title_top_bar.dart';

class ProductReviewPage extends StatefulWidget {
  const ProductReviewPage({super.key});

  @override
  State<ProductReviewPage> createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  final ImagePicker _imagePicker = ImagePicker();
  int _rating = 0;
  String? _skinType;
  final Set<String> _skinConcerns = <String>{};
  String? _skinTone;
  final TextEditingController _reviewController = TextEditingController();
  XFile? _selectedReviewImage;

  static const List<String> _skinTypes = [
    'Combination',
    'Oily',
    'Dry',
    'Normal',
    'Sensitive',
  ];

  static const List<String> _skinConcernsOptions = [
    'Acne',
    'Anti-Age',
    'Brightening',
    'Calming',
    'Dryness',
    'Oil Control',
    'Pore care',
    'Dark spots',
  ];

  static const List<String> _skinTones = [
    'Porcelain',
    'Fair',
    'Medium',
    'Tan',
    'Olive',
  ];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _rating > 0 && _reviewController.text.trim().isNotEmpty;

  void _toggleConcern(String concern) {
    setState(() {
      if (_skinConcerns.contains(concern)) {
        _skinConcerns.remove(concern);
      } else {
        _skinConcerns.add(concern);
      }
    });
  }

  void _submitReview() {
    if (!_canSubmit) {
      return;
    }

    final tags = <String>[
      if (_skinTone != null) 'Skin Tone $_skinTone',
      if (_skinType != null) 'Skin Type $_skinType',
      ..._skinConcerns.map((concern) => 'Skin Concern $concern'),
    ];

    final now = DateTime.now();
    final dateLabel =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    Navigator.of(context).pop(
      ProductReview(
        author: 'You',
        dateLabel: dateLabel,
        rating: _rating.toDouble(),
        comment: _reviewController.text.trim(),
        tags: tags,
        avatarText: 'YU',
        fileImagePath: _selectedReviewImage?.path,
      ),
    );
  }

  Future<void> _pickReviewImage() async {
    try {
      final selectedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 88,
        maxWidth: 1800,
      );

      if (selectedImage == null || !mounted) {
        return;
      }

      setState(() => _selectedReviewImage = selectedImage);
    } on PlatformException {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Image upload is not ready yet. Please fully restart the app and try again.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open the photo library right now.'),
        ),
      );
    }
  }

  void _clearReviewImage() {
    setState(() => _selectedReviewImage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CenterTitleTopBar(
              title: 'Product Review',
              trailing: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.textSecondary,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(26, 10, 26, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 38),
                    _SectionTitle(title: 'How would you rate this product?'),
                    const SizedBox(height: 14),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          final isActive = index < _rating;
                          return IconButton(
                            onPressed: () =>
                                setState(() => _rating = index + 1),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints.tightFor(
                              width: 34,
                              height: 34,
                            ),
                            icon: Icon(
                              Icons.star_rounded,
                              size: 34,
                              color: isActive
                                  ? AppColors.star
                                  : const Color(0xFFD8DCE2),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 50),
                    _SectionTitle(title: 'What is your skin type?'),
                    const SizedBox(height: 18),
                    Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: _skinTypes.map((type) {
                          return _OutlineChoiceChip(
                            label: type,
                            isSelected: _skinType == type,
                            onTap: () => setState(() => _skinType = type),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 64),
                    _SectionTitle(title: 'What is your skin concern?'),
                    const SizedBox(height: 18),
                    Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: _skinConcernsOptions.map((concern) {
                          return _OutlineChoiceChip(
                            label: concern,
                            isSelected: _skinConcerns.contains(concern),
                            onTap: () => _toggleConcern(concern),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 64),
                    _SectionTitle(title: 'Skin Tone'),
                    const SizedBox(height: 18),
                    Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: _skinTones.map((tone) {
                          return _OutlineChoiceChip(
                            label: tone,
                            isSelected: _skinTone == tone,
                            onTap: () => setState(() => _skinTone = tone),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 70),
                    Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Share your review with us.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _reviewController,
                      onChanged: (_) => setState(() {}),
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'type here..',
                        hintStyle: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: const Color(0xFFC7CAD0)),
                        contentPadding: const EdgeInsets.all(14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color(0xFFB8B8B8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: AppColors.accent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    InkWell(
                      onTap: _pickReviewImage,
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFD7D7D7),
                            style: BorderStyle.solid,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _selectedReviewImage == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    color: AppColors.textSecondary,
                                    size: 30,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Upload',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    File(_selectedReviewImage!.path),
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    right: 6,
                                    top: 6,
                                    child: InkWell(
                                      onTap: _clearReviewImage,
                                      borderRadius: BorderRadius.circular(999),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(
                                            alpha: 0.55,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Reviews that violate our policy such as inappropriate content, copied images, or promotional messages may be removed without notice.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Review Policy',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 34),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _canSubmit ? _submitReview : null,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: AppColors.accent.withValues(
                            alpha: 0.55,
                          ),
                          disabledForegroundColor: Colors.white.withValues(
                            alpha: 0.92,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Submit Review',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _OutlineChoiceChip extends StatelessWidget {
  const _OutlineChoiceChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.primary;
    final textColor = AppColors.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.14)
              : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
