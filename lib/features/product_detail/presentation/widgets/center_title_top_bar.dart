import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CenterTitleTopBar extends StatelessWidget {
  const CenterTitleTopBar({
    super.key,
    this.title,
    this.logoAssetPath,
    this.onBackTap,
    this.trailing,
  }) : assert(
         title != null || logoAssetPath != null,
         'Provide either a title or a logoAssetPath.',
       );

  final String? title;
  final String? logoAssetPath;
  final VoidCallback? onBackTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: SizedBox(
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: logoAssetPath != null
                  ? Image.asset(logoAssetPath!, height: 40, fit: BoxFit.contain)
                  : Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: IconButton(
                    onPressed: onBackTap ?? () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 44,
                  height: 44,
                  child: Center(
                    child:
                        trailing ??
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.textSecondary,
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
