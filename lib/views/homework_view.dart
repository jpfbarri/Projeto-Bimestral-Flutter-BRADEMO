import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/stellar_background.dart';
import 'dashboard_view.dart';

class HomeworkView extends StatelessWidget {
  const HomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.violet,
      body: SafeArea(
        bottom: false,
        child: StellarBackground(
          child: Column(
            children: [
              SizedBox(
                height: 74,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Text('Homework',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30)),
                  ),
                  child: ListView(
                    children: const [
                      _SectionTitle('Today'),
                      HomeworkTile(
                          title: 'Complete the present perfect lesson',
                          subtitle: 'Grammar  /  Today',
                          checked: false),
                      SizedBox(height: 8),
                      HomeworkTile(
                          title: 'Review 20 travel words',
                          subtitle: 'Vocabulary',
                          checked: true),
                      SizedBox(height: 8),
                      HomeworkTile(
                          title: 'Record your daily routine',
                          subtitle: 'Speaking',
                          checked: true),
                      SizedBox(height: 8),
                      HomeworkTile(
                          title: 'Listen to the airport dialogue',
                          subtitle: 'Listening',
                          checked: false),
                      _SectionTitle('Yesterday'),
                      HomeworkTile(
                          title: 'Learn Chapter 5 with one Essay',
                          subtitle: 'English  /  Today',
                          checked: false),
                      SizedBox(height: 8),
                      HomeworkTile(
                          title: 'Exercise Trigonometry 1st topic',
                          subtitle: 'Maths',
                          checked: true),
                      _SectionTitle('16 March 2020'),
                      HomeworkTile(
                          title: 'Learn Chapter 5 with one Essay',
                          subtitle: 'English',
                          checked: false),
                      SizedBox(height: 8),
                      HomeworkTile(
                          title: 'Exercise Trigonometry 1st topic',
                          subtitle: 'Maths',
                          checked: true),
                      _SectionTitle('15 March 2020'),
                      HomeworkTile(
                          title: 'Learn Chapter 5 with one Essay',
                          subtitle: 'English',
                          checked: false),
                      SizedBox(height: 8),
                      HomeworkTile(
                          title: 'Exercise Trigonometry 1st topic',
                          subtitle: 'Maths',
                          checked: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 10),
      child: Text(text,
          style: const TextStyle(color: AppColors.violet, fontSize: 16)),
    );
  }
}
