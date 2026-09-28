# Fluently — Projeto Bimestral Flutter

Aplicativo de aprendizagem de inglês desenvolvido para a disciplina de
Desenvolvimento para Dispositivos Móveis (BRADEMO), adaptado visualmente do
**Stellar School Mobile App UI Kit**.

O projeto trabalha somente com interface, navegação e dados estáticos. Não há
backend, banco de dados ou gerenciamento de estado externo.

## Telas do Figma implementadas

O projeto contém o fluxo completo do kit: splash, três onboardings, login,
recuperação de senha, OTP vazio e preenchido, nova senha, dashboard, menu,
homework, calendário, assinatura e pagamento expandido, multimídia,
avaliações, execução de prova, avisos, perfil, trilha de aprendizagem,
frequência mensal, relatório de progresso e cartão detalhado. O menu também
dá acesso ao fluxo exigido pela avaliação: lista de cursos, detalhes do item
selecionado e formulário de inscrição com validação.

Os conceitos escolares foram mapeados para o Fluently sem alterar a linguagem
visual: mensalidades viraram assinatura, presença virou consistência de estudo,
ano acadêmico virou trilha CEFR e provas viraram avaliações de proficiência.

## Critérios da atividade

| Critério | Implementação |
| --- | --- |
| RC1 | Pastas `views`, `widgets`, `models` e `theme` |
| RC2 | Navegação com `Navigator.push` e `pushReplacement` |
| RC3 | Objeto `Course` enviado pelo construtor para os detalhes |
| RC4 | `Form`, `TextFormField`, validações e `debugPrint` |
| RC5 | `LayoutBuilder`, `SingleChildScrollView` e `ConstrainedBox` |
| RC6 | `ThemeData` centralizado em `AppTheme` |
| RC7 | `AppBar` e `NavigationBar` Material |

## Estrutura principal

```text
lib/
├── main.dart
├── models/course.dart
├── theme/app_theme.dart
├── views/
│   ├── welcome_view.dart
│   ├── dashboard_view.dart
│   ├── menu_view.dart
│   ├── courses_view.dart
│   ├── course_detail_view.dart
│   ├── enrollment_form_view.dart
│   └── demais telas do kit
└── widgets/
    ├── course_card.dart
    └── stellar_brand.dart
```

## Executar

```bash
flutter pub get
flutter run
```

Para analisar e testar:

```bash
flutter analyze
flutter test
```

Referência visual: [Stellar School Mobile App UI Kit](https://www.figma.com/design/r4JXOBwQKmWqN9I1mGXAec/Stellar-School-Mobile-App-UI-Kit--Community-).
