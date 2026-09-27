import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'dashboard_view.dart';
import 'feature_views.dart';
import 'homework_view.dart';
import 'sign_in_view.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    const items = <_MenuItem>[
      _MenuItem('Dashboard', Icons.home_outlined, DashboardView()),
      _MenuItem('Homework', Icons.task_alt_outlined, HomeworkView()),
      _MenuItem('Attendance', Icons.calendar_month_outlined,
          StudyAttendanceView()),
      _MenuItem(
          'Subscription', Icons.credit_card_outlined, SubscriptionView()),
      _MenuItem('Assessments', Icons.quiz_outlined, ExaminationsView()),
      _MenuItem(
          'Reports', Icons.assessment_outlined, ProgressReportView()),
      _MenuItem('Calendar', Icons.event_outlined, CalendarView()),
      _MenuItem('Notice Board', Icons.campaign_outlined, NoticesView()),
      _MenuItem(
          'Multimedia', Icons.ondemand_video_outlined, MultimediaView()),
      _MenuItem(
          'Learning Path', Icons.route_outlined, LearningPathView()),
      _MenuItem('Profile', Icons.person_outline, ProfileView()),
    ];
    return Scaffold(
      backgroundColor: AppColors.violet,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: AppColors.violet),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Yasmin Alves',
                            style:
                                TextStyle(color: Colors.white, fontSize: 19)),
                        Text('B1 Intermediate',
                            style: TextStyle(color: Color(0xFFCBC7EC))),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 42),
              Expanded(
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.92,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(55),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item.page),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Icon(item.icon,
                                color: AppColors.violet, size: 38),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInView()),
                  (_) => false,
                ),
                child: const Text('Logout',
                    style: TextStyle(color: AppColors.coral, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem(this.label, this.icon, this.page);

  final String label;
  final IconData icon;
  final Widget page;
}
