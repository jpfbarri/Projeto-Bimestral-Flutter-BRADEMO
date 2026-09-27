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
    title: 'Matemática',
    teacher: 'Prof. Rafael Moreira',
    category: 'Ciências Exatas',
    description:
        'Explore funções, geometria e raciocínio lógico com atividades práticas e desafios semanais.',
    progress: 0.72,
    icon: Icons.calculate_outlined,
    color: Color(0xFFD6F8E9),
    modules: [
      'Funções e gráficos',
      'Geometria plana',
      'Trigonometria',
      'Revisão e exercícios',
    ],
  ),
  Course(
    title: 'Ciências',
    teacher: 'Profa. Helena Costa',
    category: 'Natureza',
    description:
        'Investigue fenômenos naturais, matéria, energia e os sistemas que sustentam a vida.',
    progress: 0.48,
    icon: Icons.science_outlined,
    color: Color(0xFFD4F2FA),
    modules: [
      'Matéria e energia',
      'Ecossistemas',
      'Corpo humano',
      'Laboratório guiado',
    ],
  ),
  Course(
    title: 'Língua Portuguesa',
    teacher: 'Profa. Camila Nunes',
    category: 'Linguagens',
    description:
        'Desenvolva leitura crítica, produção textual e domínio dos recursos da língua portuguesa.',
    progress: 0.86,
    icon: Icons.menu_book_outlined,
    color: Color(0xFFFFEEE9),
    modules: [
      'Leitura e interpretação',
      'Gêneros textuais',
      'Gramática em contexto',
      'Produção textual',
    ],
  ),
  Course(
    title: 'História',
    teacher: 'Prof. André Ribeiro',
    category: 'Ciências Humanas',
    description:
        'Compreenda processos históricos e conecte acontecimentos do passado aos desafios atuais.',
    progress: 0.35,
    icon: Icons.account_balance_outlined,
    color: Color(0xFFE9E4FF),
    modules: [
      'Fontes históricas',
      'Mundo antigo',
      'Brasil colonial',
      'História contemporânea',
    ],
  ),
];
