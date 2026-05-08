import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_detail.dart';

class ColorSelectionResult {
  const ColorSelectionResult({
    required this.selectedOption,
    required this.quantity,
    required this.startGlobalOffset,
  });

  final ProductColorOption selectedOption;
  final int quantity;
  final Offset startGlobalOffset;
}

class ProductColorSelectionDialog extends StatefulWidget {
  const ProductColorSelectionDialog({super.key, required this.product});

  final ProductDetail product;

  @override
  State<ProductColorSelectionDialog> createState() =>
      _ProductColorSelectionDialogState();
}

class _ProductColorSelectionDialogState
    extends State<ProductColorSelectionDialog> {
  int _selectedIndex = 0;
  int _quantity = 1;
  final GlobalKey _addToCartButtonKey = GlobalKey();

  void _submitSelection() {
    final renderBox =
        _addToCartButtonKey.currentContext?.findRenderObject() as RenderBox?;
    final startGlobalOffset = renderBox != null
        ? renderBox.localToGlobal(renderBox.size.center(Offset.zero))
        : Offset.zero;

    Navigator.of(context).pop(
      ColorSelectionResult(
        selectedOption: widget.product.colorOptions[_selectedIndex],
        quantity: _quantity,
        startGlobalOffset: startGlobalOffset,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.product.colorOptions;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Option/Color',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 0.94,
              ),
              itemBuilder: (context, index) {
                final option = colors[index];
                final isSelected = index == _selectedIndex;

                return _ColorOptionTile(
                  assetPath: option.assetPath,
                  color: option.value,
                  isSelected: isSelected,
                  onTap: () => setState(() => _selectedIndex = index),
                );
              },
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                _QuantityButton(
                  icon: Icons.remove,
                  onTap: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                ),
                const SizedBox(width: 16),
                Text(
                  '$_quantity',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 16),
                _QuantityButton(
                  icon: Icons.add,
                  onTap: () => setState(() => _quantity++),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: SizedBox(
                    key: _addToCartButtonKey,
                    child: FilledButton(
                      onPressed: _submitSelection,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'add to cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorOptionTile extends StatelessWidget {
  const _ColorOptionTile({
    required this.assetPath,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String assetPath;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : Colors.transparent,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 2,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.42),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Image.asset(assetPath, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.textSecondary),
        ),
        child: Icon(
          icon,
          size: 18,
          color: onTap == null ? AppColors.border : AppColors.textPrimary,
        ),
      ),
    );
  }
}
