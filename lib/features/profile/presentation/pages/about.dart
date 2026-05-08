import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.primary,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'About us',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Center(
              child: Column(
                children: [
                  Text(
                    'Eternal',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Shine',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome to our cosmetic app, your go-to destination for beauty and self-care. We are dedicated to helping you discover high-quality skincare and makeup products that suit your unique style and needs.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Our mission is to make beauty simple, accessible, and enjoyable for everyone. From trending products to trusted essentials, we carefully curate items to ensure you get the best experience.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'With easy browsing, personalized recommendations, and secure shopping, we aim to bring confidence and convenience right to your fingertips.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Find us on',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            _ContactRow(
              icon: Icons.language,
              label: 'Website: ',
              linkText: 'https://external-shine.com',
              url: 'https://external-shine.com',
              onTap: _launchUrl,
            ),
            const SizedBox(height: 8),
            _ContactRow(
              icon: Icons.email_outlined,
              label: 'Email: ',
              linkText: 'external-shine@email.com',
              url: 'mailto:external-shine@email.com',
              onTap: _launchUrl,
            ),
            const SizedBox(height: 8),
            _ContactRow(
              icon: Icons.location_on_outlined,
              label: 'Location (Google Maps)',
              linkText:
                  'https://maps.google.com/?q=western+university+Location',
              url: 'https://maps.google.com/?q=western+university+Location',
              onTap: _launchUrl,
            ),
            const SizedBox(height: 16),
            const Text(
              'Social Media',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            _SocialRow(
              platform: 'Instagram',
              url: 'https://instagram.com/external-shine',
              onTap: _launchUrl,
            ),
            const SizedBox(height: 6),
            _SocialRow(
              platform: 'TikTok',
              url: 'https://tiktok.com/@external-shine',
              onTap: _launchUrl,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String linkText;
  final String url;
  final Future<void> Function(String) onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.linkText,
    required this.url,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(url),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextSpan(
                    text: linkText,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.reviewChipText,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final String platform;
  final String url;
  final Future<void> Function(String) onTap;

  const _SocialRow({
    required this.platform,
    required this.url,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(url),
      child: Row(
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
          Text(
            '$platform: ',
            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          ),
          Expanded(
            child: Text(
              url,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.reviewChipText,
                decoration: TextDecoration.underline,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
