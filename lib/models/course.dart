import 'package:flutter/material.dart';

class Course {
  const Course({
    required this.title,
    required this.teacher,
    required this.category,
    required this.description,
    required this.progress,
    required this.icon,
    required this.color,
    required this.modules,
  });

  final String title;
  final String teacher;
  final String category;
  final String description;
  final double progress;
  final IconData icon;
  final Color color;
  final List<String> modules;
}

const courses = <Course>[
  Course(
    title: 'English Grammar',
    teacher: 'Tutor Marina Lopes',
    category: 'Grammar',
    description:
        'Build accurate sentences and communicate with confidence through short, practical lessons.',
    progress: 0.72,
    icon: Icons.spellcheck_outlined,
    color: Color(0xFFD6F8E9),
    modules: [
      'Present and past tenses',
      'Future forms',
      'Modal verbs',
      'Grammar review',
    ],
  ),
  Course(
    title: 'Everyday Vocabulary',
    teacher: 'Tutor Helena Costa',
    category: 'Vocabulary',
    description:
        'Expand your vocabulary for travel, work and everyday conversations with contextual practice.',
    progress: 0.48,
    icon: Icons.translate_outlined,
    color: Color(0xFFD4F2FA),
    modules: [
      'Daily routines',
      'Travel essentials',
      'Work and study',
      'Vocabulary challenge',
    ],
  ),
  Course(
    title: 'Speaking Practice',
    teacher: 'Tutor Camila Nunes',
    category: 'Speaking',
    description:
        'Improve pronunciation, fluency and confidence with guided dialogues and speaking challenges.',
    progress: 0.86,
    icon: Icons.record_voice_over_outlined,
    color: Color(0xFFFFEEE9),
    modules: [
      'Introducing yourself',
      'Everyday conversations',
      'Pronunciation lab',
      'Speaking challenge',
    ],
  ),
  Course(
    title: 'Listening Skills',
    teacher: 'Tutor André Ribeiro',
    category: 'Listening',
    description:
        'Train your ear with real-life dialogues, different accents and comprehension activities.',
    progress: 0.35,
    icon: Icons.headphones_outlined,
    color: Color(0xFFE9E4FF),
    modules: [
      'Listening for key words',
      'Airport conversations',
      'Podcasts and interviews',
      'Listening checkpoint',
    ],
  ),
];
