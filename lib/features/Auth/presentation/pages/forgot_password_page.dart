import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_shared_widgets.dart';
import 'verify_code_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _isLoading = false;
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(email);

  Future<void> _sendOTP() async {
    final email = _emailCtrl.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address.'),
          backgroundColor: AppColors.accent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
          backgroundColor: AppColors.accent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Replace with real OTP send
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        // Pass the email so VerifyCodePage can display it
        builder: (_) => VerifyCodePage(email: email),
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

              Text('Forgot Password?', style: tt.headlineLarge),

              const SizedBox(height: 10),

              Text(
                "Enter your email and we'll send you a one-time code to reset your password.",
                style: tt.bodyMedium,
              ),

              const SizedBox(height: 40),

              Text(
                'Email',
                style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              AuthTextField(
                controller: _emailCtrl,
                hint: 'example@gmail.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
              ),

              const SizedBox(height: 40),

              AuthPrimaryButton(
                label: 'Send OTP',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _sendOTP,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
