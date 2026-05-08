import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_shared_widgets.dart';
import 'create_new_password_page.dart';
class VerifyCodePage extends StatefulWidget {
  /// The email address the OTP was sent to. Displayed in the subtitle.
  final String email;

  const VerifyCodePage({super.key, required this.email});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _otpCtrl = TextEditingController();
  final _focusNode = FocusNode();
  static const int _otpLength = 5;
  bool _isLoading = false;
  bool _isResending = false;

  @override
  void dispose() {
    _otpCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    _focusNode.unfocus();
    setState(() => _isLoading = true);
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Replace with real verify
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
    );
  }

  Future<void> _resendCode() async {
    setState(() => _isResending = true);
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Replace with real resend
    if (!mounted) return;
    setState(() {
      _isResending = false;
      _otpCtrl.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new code has been sent.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final canVerify = _otpCtrl.text.length == _otpLength;

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

              Text('Verify Your Code', style: tt.headlineLarge),

              const SizedBox(height: 12),

              RichText(
                text: TextSpan(
                  style: tt.bodyMedium,
                  children: [
                    const TextSpan(text: 'We sent a 5-digit code to '),
                    TextSpan(
                      text: widget.email,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Hidden input field drives the visible OTP boxes
              Stack(
                children: [
                  Opacity(
                    opacity: 0,
                    child: TextField(
                      controller: _otpCtrl,
                      focusNode: _focusNode,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: _otpLength,
                      autofillHints: const [AutofillHints.oneTimeCode],
                      decoration: const InputDecoration(counterText: ''),
                      onChanged: (v) {
                        setState(() {});
                        if (v.length == _otpLength) _verify();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _focusNode.requestFocus(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_otpLength, (i) {
                        final char = _otpCtrl.text.length > i
                            ? _otpCtrl.text[i]
                            : '';
                        final isCurrent = _otpCtrl.text.length == i;
                        return _OTPBox(char: char, isCurrent: isCurrent);
                      }),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              AuthPrimaryButton(
                label: 'Verify',
                isLoading: _isLoading,
                onPressed: (canVerify && !_isLoading) ? _verify : null,
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive the code? ", style: tt.bodyMedium),
                  GestureDetector(
                    onTap: _isResending ? null : _resendCode,
                    child: _isResending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : Text(
                            'Resend Code',
                            style: tt.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _OTPBox extends StatelessWidget {
  final String char;
  final bool isCurrent;

  const _OTPBox({required this.char, this.isCurrent = false});

  @override
  Widget build(BuildContext context) {
    final filled = char.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 60,
      width: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: filled
              ? AppColors.primary
              : isCurrent
              ? AppColors.primary
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Text(
        filled ? char : '–',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: filled ? AppColors.textPrimary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
