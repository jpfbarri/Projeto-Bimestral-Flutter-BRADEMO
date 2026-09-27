import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StellarBrand extends StatelessWidget {
  const StellarBrand({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 42.0 : 92.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.coral,
            borderRadius: BorderRadius.circular(compact ? 14 : 30),
          ),
          child: Icon(
            Icons.school_outlined,
            color: Colors.white,
            size: size * 0.58,
          ),
        ),
        SizedBox(width: compact ? 12 : 18),
        Text(
          compact ? 'Stellar' : 'Stellar\nSchool',
          style: TextStyle(
            color: Colors.white,
            fontSize: compact ? 22 : 34,
            height: 1.05,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
