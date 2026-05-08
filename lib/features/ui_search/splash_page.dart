// lib/features/splash/presentation/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/router/app_router.dart';

// ── Onboarding data ───────────────────────────────────────────────────────────
class _Item {
  final String title;
  final String subtitle;
  final String image;
  const _Item({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

const _kItems = [
  _Item(
    title: 'Your Personal Beauty Store',
    subtitle:
        'Shop top beauty products handpicked for your skin.\nSimple, smart, and tailored to you.',
    image: 'assets/images/poster1.png',
  ),
  _Item(
    title: 'Tell Us About Your Skin',
    subtitle: 'Answer a few questions for better recommendations.',
    image: 'assets/images/Rosé _ Sulwhasoo.jpg',
  ),
  _Item(
    title: 'Personalise Your Glow',
    subtitle: 'Select concerns like acne or dryness.',
    image: 'assets/images/9774499e5f3e3acc187d47319c2763be.jpg',
  ),
  _Item(
    title: "Let's Glow",
    subtitle: 'Start your personalised skincare journey.',
    image: 'assets/images/poster4.png',
  ),
];

// ═════════════════════════════════════════════════════════════════════════════
// SPLASH — new animation, same centred layout
// ═════════════════════════════════════════════════════════════════════════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // Logo bounces in with overshoot → settle
  late final Animation<double> _logoScale;
  // Background: primary pink → background
  late final Animation<Color?> _bgColor;
  // Logo tint: white → primary
  late final Animation<Color?> _logoTint;
  // Logo slides upward as page exits
  late final Animation<Offset> _logoSlide;
  // Whole screen fades out
  late final Animation<double> _screenFade;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // ── Logo: 0 → 1.18 (overshoot) → 1.0 (settle) → hold ────────────
    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.18,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.18,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
    ]).animate(_ctrl);

    // ── Background colour transition ──────────────────────────────────
    _bgColor = ColorTween(begin: AppColors.primary, end: AppColors.background)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.38, 0.72, curve: Curves.easeInOut),
          ),
        );

    // ── Logo tint transition ──────────────────────────────────────────
    _logoTint = ColorTween(begin: AppColors.surface, end: AppColors.primary)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.38, 0.72, curve: Curves.easeInOut),
          ),
        );

    // ── Logo slides up on exit ────────────────────────────────────────
    _logoSlide = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.6))
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.80, 1.0, curve: Curves.easeInCubic),
          ),
        );

    // ── Screen fades out ──────────────────────────────────────────────
    _screenFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.90, 1.0, curve: Curves.easeIn),
      ),
    );

    _ctrl.forward();
    _ctrl.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const _OnboardingScreen(),
            transitionsBuilder: (_, anim, _, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, _) => FadeTransition(
        opacity: _screenFade,
        child: Scaffold(
          backgroundColor: _bgColor.value,
          body: Center(
            child: SlideTransition(
              position: _logoSlide,
              child: ScaleTransition(
                scale: _logoScale,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: MediaQuery.of(context).size.width * 0.50,
                  color: _logoTint.value,
                  errorBuilder: (_, _, _) => Text(
                    'ETERNAL SHINE',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _logoTint.value,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// ONBOARDING — original full-screen layout with AppColors + Poppins
// ═════════════════════════════════════════════════════════════════════════════
class _OnboardingScreen extends StatefulWidget {
  const _OnboardingScreen();
  @override
  State<_OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<_OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _pageCtrl = PageController();
  int _page = 0;

  // Logo slides down into place on entry
  late final AnimationController _entryCtrl;
  late final Animation<Offset> _logoSlide;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut));
    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final isLastPage = _page == _kItems.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── 1. Background poster — crossfade on page change ────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Container(
              key: ValueKey('bg_$_page'),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_kItems[_page].image),
                  fit: BoxFit.cover,
                  onError: (_, _) {},
                ),
              ),
            ),
          ),

          // ── 2. Gradient overlay ────────────────────────────────
          // Top soft pink — keeps logo readable on any photo
          // Bottom deep fade — text + controls always legible
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.22, 0.55, 1.0],
                colors: [
                  Color(0xBBFFAEC7), // secondary ~73% — top tint
                  Color.fromARGB(51, 255, 255, 255), // fade to transparent
                ],
              ),
            ),
          ),

          // ── 3. Logo ────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),
                SlideTransition(
                  position: _logoSlide,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    height: 40,
                    color: AppColors.surface,
                    errorBuilder: (_, _, _) => Text(
                      'ETERNAL SHINE',
                      style: tt.titleMedium?.copyWith(
                        color: AppColors.surface,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                // ── 4. PageView — title + subtitle ────────────────
                Expanded(
                  child: PageView.builder(
                    controller: _pageCtrl,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemCount: _kItems.length,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _kItems[i].title,
                              style: tt.headlineMedium?.copyWith(
                                color: AppColors.surface,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _kItems[i].subtitle,
                              style: tt.bodyMedium?.copyWith(
                                color: AppColors.surface.withValues(
                                  alpha: 0.80,
                                ),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 100), // space for controls
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── 5. Bottom controls ─────────────────────────────────
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: isLastPage
                ? _AuthButtons(
                    onLogin: () =>
                        Navigator.pushNamed(context, AppRouter.login),
                    onSignUp: () =>
                        Navigator.pushNamed(context, AppRouter.signUp),
                  )
                : _NavRow(
                    page: _page,
                    total: _kItems.length,
                    onSkip: () => _pageCtrl.animateToPage(
                      _kItems.length - 1,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                    ),
                    onNext: () => _pageCtrl.nextPage(
                      duration: const Duration(milliseconds: 450),
                      curve: Curves.easeOutCubic,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Skip / dots / next ────────────────────────────────────────────────────────
class _NavRow extends StatelessWidget {
  final int page;
  final int total;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const _NavRow({
    required this.page,
    required this.total,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Skip
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style: tt.bodyMedium?.copyWith(
              color: AppColors.surface.withValues(alpha: 0.70),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Dot indicators
        Row(
          children: List.generate(total, (i) {
            final active = page == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 22 : 7,
              height: 6,
              decoration: BoxDecoration(
                // Active dot: primary pink; inactive: translucent white
                color: active
                    ? AppColors.primary
                    : AppColors.surface.withValues(alpha: 0.40),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),

        // Next — pink filled circle
        GestureDetector(
          onTap: onNext,
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.secondary,
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.surface,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Login + Sign Up (last page) ───────────────────────────────────────────────
class _AuthButtons extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onSignUp;

  const _AuthButtons({required this.onLogin, required this.onSignUp});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        // Log In — white outlined
        Expanded(
          child: OutlinedButton(
            onPressed: onLogin,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.surface.withValues(alpha: 0.15),
              side: const BorderSide(color: AppColors.surface, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Log In',
              style: tt.bodyLarge?.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Sign Up — primary filled
        Expanded(
          child: ElevatedButton(
            onPressed: onSignUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.surface,
              padding: const EdgeInsets.symmetric(vertical: 18),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Sign Up',
              style: tt.bodyLarge?.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
