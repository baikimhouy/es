import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_shared_widgets.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _validateInputs() {
    final pw = _passwordCtrl.text;
    final cpw = _confirmCtrl.text;

    if (pw.isEmpty) return 'Please enter a new password.';
    if (pw.length < 6) return 'Password must be at least 6 characters.';
    if (cpw.isEmpty) return 'Please confirm your new password.';
    if (pw != cpw) return 'Passwords do not match.';
    return null;
  }

  Future<void> _handleReset() async {
    final error = _validateInputs();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.accent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Replace with real reset
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Clear the entire back stack and go to login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset successfully. Please sign in.'),
        backgroundColor: Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthBackAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              Image.asset(
                'assets/images/app_logo.png',
                height: 50,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Text(
                  'GlowUp',
                  style: tt.headlineMedium?.copyWith(color: AppColors.primary),
                ),
              ),

              const SizedBox(height: 16),

              Text('Reset Password', style: tt.headlineLarge),

              const SizedBox(height: 10),

              Text(
                'Your identity has been verified. Set your new password below.',
                style: tt.bodyMedium,
              ),

              const SizedBox(height: 40),

              Text(
                'New Password',
                style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              AuthTextField(
                controller: _passwordCtrl,
                hint: 'At least 6 characters',
                icon: Icons.lock_outline,
                obscure: _obscurePassword,
                autofillHints: const [AutofillHints.newPassword],
                onToggleObscure: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),

              const SizedBox(height: 24),

              Text(
                'Confirm Password',
                style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              AuthTextField(
                controller: _confirmCtrl,
                hint: 'Repeat your new password',
                icon: Icons.lock_reset_outlined,
                obscure: _obscureConfirmPassword,
                onToggleObscure: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                ),
              ),

              const SizedBox(height: 40),

              AuthPrimaryButton(
                label: 'Reset Password',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleReset,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
