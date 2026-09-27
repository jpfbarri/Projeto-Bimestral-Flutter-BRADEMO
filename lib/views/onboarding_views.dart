import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'sign_in_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _controller = PageController();
  int _page = 0;

  static const _pages = [
    _OnboardingData(
      title: 'Complete daily\nEnglish lessons',
      subtitle: 'Build a consistent routine with short activities.',
      background: Color(0xFFFFE7D2),
      icon: Icons.task_alt_rounded,
    ),
    _OnboardingData(
      title: 'Practice your\npronunciation',
      subtitle: 'Listen, repeat and improve your speaking confidence.',
      background: Color(0xFFD8F5FC),
      icon: Icons.record_voice_over_rounded,
    ),
    _OnboardingData(
      title: 'Take tests & track\nyour progress',
      subtitle: 'See your evolution from beginner to fluent speaker.',
      background: Color(0xFFFFD9DB),
      icon: Icons.workspace_premium_rounded,
    ),
  ];

  void _next() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInView()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        onPageChanged: (value) => setState(() => _page = value),
        itemBuilder: (context, index) {
          final data = _pages[index];
          return ColoredBox(
            color: data.background,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 58, 28, 34),
                child: Column(
                  children: [
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 33,
                        height: 1.15,
                        color: Color(0xFF111114),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 260),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.42),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              data.icon,
                              size: 130,
                              color: AppColors.violet,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (dot) => Container(
                          width: dot == _page ? 22 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: dot == _page
                                ? AppColors.violet
                                : AppColors.violet.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FilledButton(
                        onPressed: _next,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.violet,
                          shape: const CircleBorder(),
                        ),
                        child: Icon(
                          _page == _pages.length - 1
                              ? Icons.check_rounded
                              : Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.background,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final Color background;
  final IconData icon;
}
