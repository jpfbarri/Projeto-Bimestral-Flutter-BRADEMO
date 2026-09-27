import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FluentlyPage extends StatelessWidget {
  const FluentlyPage({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.violet,
      body: SafeArea(
        bottom: false,
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
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  if (trailing != null) trailing!,
                  const SizedBox(width: 10),
                ],
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
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    const events = [
      ('01', 'Conversation Club', 'Live class', AppColors.blush),
      ('10', 'Vocabulary Challenge', 'Practice event', AppColors.sky),
      ('22', 'Pronunciation Workshop', 'Live class', Color(0xFFFFD9DB)),
      ('26', 'Tutor Meeting', 'Feedback', AppColors.mint),
      ('30', 'Monthly Level Test', 'Assessment', AppColors.blush),
    ];
    return FluentlyPage(
      title: 'Calendar',
      trailing: const Padding(
        padding: EdgeInsets.only(right: 8),
        child:
            Text('2026⌃', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('September 2026',
              style: TextStyle(color: AppColors.violet, fontSize: 16)),
          const SizedBox(height: 18),
          const _CalendarGrid(),
          const SizedBox(height: 20),
          for (final event in events)
            _EventTile(
                day: event.$1,
                title: event.$2,
                subtitle: event.$3,
                color: event.$4),
        ],
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('M'),
            Text('T'),
            Text('W'),
            Text('T'),
            Text('F'),
            Text('S'),
            Text('S'),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 35,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.12,
          ),
          itemBuilder: (context, index) {
            final day = index + 1;
            final selected = day == 8;
            return Center(
              child: Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: selected
                    ? const BoxDecoration(
                        color: AppColors.coral, shape: BoxShape.circle)
                    : null,
                child: Text(
                  day <= 30 ? '$day' : '',
                  style: TextStyle(
                      color: selected ? Colors.white : AppColors.text),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile(
      {required this.day,
      required this.title,
      required this.subtitle,
      required this.color});

  final String day;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.coral,
            child: Text(day,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(11)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Text(subtitle, style: const TextStyle(color: AppColors.muted))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key, this.expanded = false});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    const payments = [
      ('Fluently Plus — September', 'R\$ 49,90'),
      ('Fluently Plus — August', 'R\$ 49,90'),
      ('Fluently Plus — July', 'R\$ 49,90'),
      ('Fluently Plus — June', 'R\$ 49,90'),
      ('Fluently Plus — May', 'R\$ 49,90'),
    ];
    return FluentlyPage(
      title: 'Subscription',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _TabLabel('Plan', true),
                _TabLabel('Payments', false),
                _TabLabel('Certificates', false),
                _TabLabel('Benefits', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (var index = 0; index < payments.length; index++)
            _PaymentCard(
              title: payments[index].$1,
              price: payments[index].$2,
              expanded: expanded && index == 0,
              onTap: index == 0 && !expanded
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const SubscriptionView(expanded: true)),
                      )
                  : null,
            ),
        ],
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel(this.text, this.active);

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 28),
      padding: const EdgeInsets.only(bottom: 9),
      decoration: active
          ? const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.coral, width: 2)))
          : null,
      child: Text(text,
          style: TextStyle(
              color: active ? AppColors.coral : AppColors.violet,
              fontSize: 16)),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard(
      {required this.title,
      required this.price,
      required this.expanded,
      this.onTap});

  final String title;
  final String price;
  final bool expanded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColors.sky, borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(title,
                        style: const TextStyle(color: AppColors.muted))),
                const Text('06 Sep', style: TextStyle(color: AppColors.muted)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(price,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w600)),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                      color: const Color(0xFF0BB76D),
                      borderRadius: BorderRadius.circular(20)),
                  child:
                      const Text('Paid', style: TextStyle(color: Colors.white)),
                ),
                const Spacer(),
                Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.coral),
              ],
            ),
            if (expanded) ...[
              const Divider(height: 28),
              const _PriceLine('Monthly plan', 'R\$ 44,90'),
              const _PriceLine('Live class add-on', 'R\$ 10,00'),
              const _PriceLine('Discount', '− R\$ 5,00'),
              const _PriceLine('Paid total', 'R\$ 49,90', bold: true),
            ],
          ],
        ),
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  const _PriceLine(this.label, this.value, {this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontWeight: bold ? FontWeight.w700 : FontWeight.w400))),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w400)),
        ],
      ),
    );
  }
}

class MultimediaView extends StatelessWidget {
  const MultimediaView({super.key});

  @override
  Widget build(BuildContext context) {
    const resources = [
      ('PDF', 'Essential English Vocabulary', '24 pages  /  820 KB'),
      ('Video', 'Common pronunciation mistakes', '18:30  /  12 MB'),
      ('ZIP', 'Listening practice pack', '32 audio tracks'),
      ('PDF', 'Grammar reference — B1', '46 pages  /  1.2 MB'),
      ('Audio', 'Everyday conversations', '15 lessons'),
    ];
    return FluentlyPage(
      title: 'Multimedia',
      trailing: const Icon(Icons.search, color: Colors.white),
      child: ListView(
        padding: const EdgeInsets.all(17),
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('All', style: TextStyle(color: AppColors.coral)),
              Text('Video'),
              Text('Audio'),
              Text('Documents'),
              Text('Links')
            ],
          ),
          const SizedBox(height: 16),
          for (final resource in resources)
            Container(
              margin: const EdgeInsets.only(bottom: 11),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFD0D0),
                  borderRadius: BorderRadius.circular(11)),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: const Color(0xFFB7B7C9))),
                    child: Text(resource.$1,
                        style: const TextStyle(color: AppColors.violet)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(resource.$2),
                        const SizedBox(height: 5),
                        Text(resource.$3,
                            style: const TextStyle(color: AppColors.muted))
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ExaminationsView extends StatelessWidget {
  const ExaminationsView({super.key});

  @override
  Widget build(BuildContext context) {
    const exams = [
      ('English Placement Test', false, '30 Min'),
      ('Vocabulary Level A2', true, '20 Min'),
      ('Grammar Challenge B1', false, '30 Min'),
      ('Listening Comprehension', true, '25 Min'),
      ('Speaking Assessment', false, '15 Min'),
      ('Reading Level B2', false, '30 Min'),
    ];
    return FluentlyPage(
      title: 'Assessments',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Assessment List',
              style: TextStyle(color: AppColors.violet, fontSize: 16)),
          const SizedBox(height: 12),
          for (final exam in exams)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ExamView(title: exam.$1)),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 11),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: AppColors.mint,
                    borderRadius: BorderRadius.circular(11)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exam.$1),
                          Text('◷ Duration: ${exam.$3}',
                              style: const TextStyle(color: AppColors.muted)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 3),
                            decoration: BoxDecoration(
                              color: exam.$2
                                  ? const Color(0xFF0BB76D)
                                  : AppColors.coral,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              exam.$2
                                  ? 'Score: 86%  Completed'
                                  : '▶  Start Test',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF8FC7AC)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ExamView extends StatefulWidget {
  const ExamView({super.key, required this.title});

  final String title;

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  int _question = 0;
  int? _selected;

  static const _questions = [
    (
      'Choose the correct sentence:',
      [
        'She go to work every day.',
        'She goes to work every day.',
        'She going to work every day.',
        'She gone to work every day.'
      ]
    ),
    (
      'What is the opposite of “expensive”?',
      ['Cheap', 'Heavy', 'Empty', 'Slow']
    ),
    (
      'Complete: I have lived here ___ 2022.',
      ['for', 'since', 'during', 'from']
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final item = _questions[_question];
    return FluentlyPage(
      title: 'Assessment',
      trailing: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text('29:42', style: TextStyle(color: Colors.white)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: const TextStyle(color: AppColors.violet, fontSize: 18)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (_question + 1) / _questions.length,
              color: AppColors.coral,
              backgroundColor: AppColors.blush,
            ),
            const SizedBox(height: 34),
            Text('Question ${_question + 1} of ${_questions.length}',
                style: const TextStyle(color: AppColors.muted)),
            const SizedBox(height: 8),
            Text(item.$1,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 22),
            for (var index = 0; index < item.$2.length; index++)
              ListTile(
                onTap: () => setState(() => _selected = index),
                leading: Icon(
                  _selected == index
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color:
                      _selected == index ? AppColors.violet : AppColors.muted,
                ),
                title: Text(item.$2[index]),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selected == null
                  ? null
                  : () {
                      if (_question < _questions.length - 1) {
                        setState(() {
                          _question++;
                          _selected = null;
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    },
              child: Text(_question == _questions.length - 1
                  ? 'Finish Test'
                  : 'Next Question'),
            ),
          ],
        ),
      ),
    );
  }
}

class NoticesView extends StatelessWidget {
  const NoticesView({super.key});

  @override
  Widget build(BuildContext context) {
    const notices = [
      (
        'New conversation groups are open',
        'Join a weekly small-group session with a tutor.',
        AppColors.mint,
        '02 SEP'
      ),
      (
        'English Book Fair this month',
        'Discover graded readers selected for your current level.',
        AppColors.sky,
        '06 SEP'
      ),
      (
        'Fluently pronunciation week',
        'Complete five speaking challenges and earn a badge.',
        Color(0xFFFFD9DB),
        '12 SEP'
      ),
      (
        'Monthly progress report ready',
        'Review your vocabulary, grammar and study consistency.',
        AppColors.blush,
        '20 SEP'
      ),
    ];
    return FluentlyPage(
      title: 'Notice Board',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final notice in notices)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: notice.$3, borderRadius: BorderRadius.circular(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.campaign_outlined,
                      color: AppColors.violet, size: 34),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notice.$1,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 5),
                        Text(notice.$2,
                            style: const TextStyle(color: AppColors.muted)),
                      ],
                    ),
                  ),
                  Text(notice.$4,
                      style: const TextStyle(
                          color: AppColors.coral, fontSize: 11)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const details = [
      ('Student ID', 'FL-0175'),
      ('Current Level', 'B1 Intermediate'),
      ('Native Language', 'Portuguese'),
      ('Learning Goal', 'Professional English'),
      ('Study Streak', '12 days'),
      ('Tutor', 'Marina Lopes'),
    ];
    return FluentlyPage(
      title: 'Profile',
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 26),
            color: AppColors.violet,
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 70, color: AppColors.violet),
                ),
                SizedBox(height: 14),
                Text('Yasmin Alves',
                    style: TextStyle(color: Colors.white, fontSize: 21)),
                Text('B1 Intermediate',
                    style: TextStyle(color: Color(0xFFCBC7EC))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                for (final detail in details)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      children: [
                        Expanded(child: Text(detail.$1)),
                        Expanded(
                            child: Text(detail.$2,
                                style:
                                    const TextStyle(color: AppColors.violet))),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Ask for Update')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LearningPathView extends StatelessWidget {
  const LearningPathView({super.key});

  @override
  Widget build(BuildContext context) {
    const levels = [
      ('A1', 'Beginner foundations', true),
      ('A2', 'Elementary communication', true),
      ('B1', 'Intermediate fluency', false),
      ('B2', 'Upper-intermediate confidence', false),
      ('C1', 'Advanced expression', false),
    ];
    return FluentlyPage(
      title: 'Learning Path',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Your English journey',
              style: TextStyle(color: AppColors.violet, fontSize: 18)),
          const SizedBox(height: 18),
          for (var index = 0; index < levels.length; index++)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: levels[index].$3
                          ? const Color(0xFF0BB76D)
                          : AppColors.violet,
                      child: Text(levels[index].$1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
                    if (index < levels.length - 1)
                      Container(
                          width: 2, height: 58, color: const Color(0xFFE3E0F3)),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: index == 2 ? AppColors.blush : Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: const Color(0xFFE8E6EF))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(levels[index].$2,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                            levels[index].$3
                                ? 'Completed'
                                : index == 2
                                    ? 'In progress — 64%'
                                    : 'Locked',
                            style: const TextStyle(color: AppColors.muted))
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class StudyAttendanceView extends StatelessWidget {
  const StudyAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    const months = [
      ('September', 18, 3, 1),
      ('August', 22, 2, 0),
      ('July', 19, 4, 2),
      ('June', 24, 1, 0),
      ('May', 20, 3, 1),
      ('April', 17, 5, 2),
    ];
    return FluentlyPage(
      title: 'Study Attendance',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('2026',
              style: TextStyle(color: AppColors.violet, fontSize: 18)),
          const SizedBox(height: 14),
          for (final month in months)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => StudyMonthView(month: month.$1)),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.blush,
                    borderRadius: BorderRadius.circular(11)),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(month.$1,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    _AttendanceCount(
                        value: month.$2,
                        label: 'Studied',
                        color: const Color(0xFF0BB76D)),
                    _AttendanceCount(
                        value: month.$3,
                        label: 'Missed',
                        color: AppColors.coral),
                    _AttendanceCount(
                        value: month.$4,
                        label: 'Rest',
                        color: AppColors.violet),
                    const Icon(Icons.chevron_right, color: AppColors.violet),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AttendanceCount extends StatelessWidget {
  const _AttendanceCount(
      {required this.value, required this.label, required this.color});

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Text('$value',
              style: TextStyle(color: color, fontWeight: FontWeight.w700)),
          Text(label,
              style: const TextStyle(fontSize: 9, color: AppColors.muted)),
        ],
      ),
    );
  }
}

class StudyMonthView extends StatelessWidget {
  const StudyMonthView({super.key, required this.month});

  final String month;

  @override
  Widget build(BuildContext context) {
    return FluentlyPage(
      title: month,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('M'),
              Text('T'),
              Text('W'),
              Text('T'),
              Text('F'),
              Text('S'),
              Text('S')
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 30,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7),
            itemBuilder: (context, index) {
              final missed = index == 4 || index == 16 || index == 24;
              final rest =
                  index == 6 || index == 13 || index == 20 || index == 27;
              return Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: missed
                      ? const Color(0xFFFFD9DB)
                      : rest
                          ? const Color(0xFFE7E3FA)
                          : AppColors.mint,
                  shape: BoxShape.circle,
                ),
                child:
                    Text('${index + 1}', style: const TextStyle(fontSize: 12)),
              );
            },
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Legend(color: AppColors.mint, label: 'Studied'),
              _Legend(color: Color(0xFFFFD9DB), label: 'Missed'),
              _Legend(color: Color(0xFFE7E3FA), label: 'Rest day'),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.sky, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              children: [
                Text('86%',
                    style: TextStyle(
                        fontSize: 38,
                        color: AppColors.violet,
                        fontWeight: FontWeight.w700)),
                Text('Study consistency this month'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(radius: 5, backgroundColor: color),
      const SizedBox(width: 5),
      Text(label)
    ]);
  }
}

class ProgressReportView extends StatelessWidget {
  const ProgressReportView({super.key});

  @override
  Widget build(BuildContext context) {
    const reports = [
      ('September 2026', 'B1', '86%'),
      ('August 2026', 'B1', '81%'),
      ('July 2026', 'A2', '92%'),
      ('June 2026', 'A2', '88%'),
    ];
    return FluentlyPage(
      title: 'Progress Reports',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final report in reports)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ReportCardView(period: report.$1)),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 13),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: AppColors.blush,
                    borderRadius: BorderRadius.circular(11)),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.coral,
                      child:
                          Icon(Icons.assessment_outlined, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(report.$1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          Text('CEFR Level ${report.$2}',
                              style: const TextStyle(color: AppColors.muted))
                        ])),
                    Text(report.$3,
                        style: const TextStyle(
                            color: AppColors.violet,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    const Icon(Icons.chevron_right, color: AppColors.violet),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ReportCardView extends StatelessWidget {
  const ReportCardView({super.key, required this.period});

  final String period;

  @override
  Widget build(BuildContext context) {
    const skills = [
      ('Grammar', 0.88),
      ('Vocabulary', 0.91),
      ('Listening', 0.82),
      ('Speaking', 0.78),
      ('Reading', 0.93),
      ('Writing', 0.84)
    ];
    return FluentlyPage(
      title: 'Report Card',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                color: AppColors.violet,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                const CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 42, color: AppColors.violet)),
                const SizedBox(height: 10),
                const Text('Yasmin Alves',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text(period, style: const TextStyle(color: Color(0xFFCBC7EC))),
                const SizedBox(height: 14),
                const Text('86%',
                    style: TextStyle(
                        color: AppColors.coral,
                        fontSize: 42,
                        fontWeight: FontWeight.w700)),
                const Text('Overall performance',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          for (final skill in skills)
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(child: Text(skill.$1)),
                    Text('${(skill.$2 * 100).round()}%')
                  ]),
                  const SizedBox(height: 7),
                  LinearProgressIndicator(
                      value: skill.$2,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.violet,
                      backgroundColor: const Color(0xFFE9E7F2)),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: AppColors.mint, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tutor feedback',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 7),
                Text(
                    'Excellent vocabulary growth. Keep practicing spontaneous speaking to gain more confidence.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_outlined),
              label: const Text('Download Report')),
        ],
      ),
    );
  }
}
