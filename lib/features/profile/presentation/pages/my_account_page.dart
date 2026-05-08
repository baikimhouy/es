import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/profile_data.dart';
import '../widgets/profile_avatar.dart';
import 'edit_profile_page.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

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
          'My Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: ProfileData.instance,
        builder: (context, _) {
          final p = ProfileData.instance;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Center(child: ProfileAvatar(size: 72)),
                const SizedBox(height: 28),
                _ProfileInfoRow(label: 'First Name', value: p.firstName),
                _ProfileInfoRow(label: 'Last Name', value: p.lastName),
                _ProfileInfoRow(label: 'Gender', value: p.gender),
                _PhoneInfoRow(value: p.phone),
                _ProfileInfoRow(label: 'Email', value: p.email),
                _ProfileInfoRow(label: 'Birthday', value: p.birthday),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: AppColors.divider,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

class _PhoneInfoRow extends StatelessWidget {
  final String value;
  const _PhoneInfoRow({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              const Text('🇰🇭', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: AppColors.divider,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
