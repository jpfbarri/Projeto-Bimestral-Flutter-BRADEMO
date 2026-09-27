import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StellarBackground extends StatelessWidget {
  const StellarBackground({super.key, required this.child, this.height});

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: AppColors.violet,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Icon(
                Icons.language_rounded,
                size: 430,
                color: Colors.white.withValues(alpha: 0.055),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class StellarLogo extends StatelessWidget {
  const StellarLogo({super.key, this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.translate_rounded,
          color: AppColors.coral,
          size: large ? 154 : 112,
        ),
        Text(
          'Fluently',
          style: TextStyle(
            color: AppColors.coral,
            fontSize: large ? 29 : 23,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
