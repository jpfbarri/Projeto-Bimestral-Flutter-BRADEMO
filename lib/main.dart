import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'views/welcome_view.dart';

void main() {
  runApp(const StellarSchoolApp());
}

class StellarSchoolApp extends StatelessWidget {
  const StellarSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluently',
      theme: AppTheme.light,
      home: const WelcomeView(),
    );
  }
}
