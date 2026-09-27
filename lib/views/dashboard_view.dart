import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/stellar_background.dart';
import 'homework_view.dart';
import 'menu_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const _homework = [
    ('Complete the present perfect lesson', 'Grammar  /  Today', false),
    ('Review 20 travel words', 'Vocabulary  /  Today', true),
    ('Record your daily routine', 'Speaking  /  Yesterday', false),
    ('Listen to the airport dialogue', 'Listening  /  Yesterday', false),
    ('Read “A day in London”', 'Reading  /  16 September', true),
    ('Write a short formal email', 'Writing  /  16 September', false),
  ];

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
                height: 92,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MenuView()),
                        ),
                        icon: const Icon(Icons.apps,
                            color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yasmin Alves',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              'B1 Intermediate',
                              style: TextStyle(
                                  color: Color(0xFFCBC7EC), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person,
                                color: AppColors.violet, size: 28),
                          ),
                          Positioned(
                            right: -1,
                            top: 0,
                            child: Container(
                              width: 11,
                              height: 11,
                              decoration: const BoxDecoration(
                                color: AppColors.coral,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 22, bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Notice Board',
                            style: TextStyle(
                                color: AppColors.violet, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 157,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            children: const [
                              _NoticeCard(
                                color: AppColors.mint,
                                icon: Icons.celebration_outlined,
                                text:
                                    'New conversation\ngroups are open\nthis month',
                              ),
                              _NoticeCard(
                                color: AppColors.sky,
                                icon: Icons.menu_book_outlined,
                                text:
                                    'English Book Fair\nwith graded readers\nthis month',
                              ),
                              _NoticeCard(
                                color: Color(0xFFFFD9D7),
                                icon: Icons.campaign_outlined,
                                text: 'Pronunciation week\nstarts next\nMonday',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Text(
                                'Homework',
                                style: TextStyle(
                                    color: AppColors.violet, fontSize: 20),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomeworkView(),
                                    ),
                                  );
                                },
                                child: const Text('View all'),
                              ),
                            ],
                          ),
                        ),
                        ..._homework.map(
                          (item) => Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                            child: HomeworkTile(
                              title: item.$1,
                              subtitle: item.$2,
                              checked: item.$3,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _NoticeCard extends StatelessWidget {
  const _NoticeCard(
      {required this.color, required this.icon, required this.text});

  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 144,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: AppColors.violet),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, height: 1.08),
            ),
          ),
          const SizedBox(height: 3),
          const Text('02 March 2020',
              style: TextStyle(color: AppColors.muted, fontSize: 12)),
        ],
      ),
    );
  }
}

class HomeworkTile extends StatelessWidget {
  const HomeworkTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.checked});

  final String title;
  final String subtitle;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_circle : Icons.circle_outlined,
            color: checked ? AppColors.violet : const Color(0xFF778084),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14.5, color: Color(0xFF111114))),
                const SizedBox(height: 2),
                Text(subtitle,
                    style:
                        const TextStyle(fontSize: 13, color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
