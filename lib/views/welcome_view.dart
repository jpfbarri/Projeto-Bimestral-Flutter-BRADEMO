import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/stellar_background.dart';
import 'onboarding_views.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  Timer? _timer;
  bool _isLeaving = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _openSignIn);
  }

  void _openSignIn() {
    if (!mounted || _isLeaving) return;
    _isLeaving = true;
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, secondaryAnimation) =>
            const OnboardingView(),
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _openSignIn,
        child: const StellarBackground(
          child: Center(child: StellarLogo(large: true)),
        ),
      ),
    );
  }
}
