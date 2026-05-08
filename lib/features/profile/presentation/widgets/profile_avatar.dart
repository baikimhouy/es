import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/profile_data.dart';

class ProfileAvatar extends StatelessWidget {
  final double size;
  final bool showEditBadge;
  final VoidCallback? onEditTap;

  const ProfileAvatar({
    super.key,
    this.size = 72,
    this.showEditBadge = false,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ProfileData.instance,
      builder: (_, _) {
        final bytes = ProfileData.instance.avatarBytes;
        final avatar = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2),
            color: AppColors.textPrimary,
          ),
          child: ClipOval(
            child: bytes != null
                ? Image.memory(bytes, fit: BoxFit.cover)
                : Container(
                    color: AppColors.textPrimary,
                    child: Icon(
                      Icons.person,
                      color: AppColors.surface,
                      size: size * 0.55,
                    ),
                  ),
          ),
        );

        if (!showEditBadge) return avatar;

        final badgeSize = size * 0.30;
        return Stack(
          children: [
            avatar,
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEditTap,
                child: Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: AppColors.surface,
                    size: badgeSize * 0.55,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
