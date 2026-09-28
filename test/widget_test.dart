import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stellar_school/main.dart';

void main() {
  testWidgets('percorre onboarding, login e dashboard do Fluently', (
    tester,
  ) async {
    await tester.pumpWidget(const StellarSchoolApp());

    expect(find.text('Fluently'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();

    expect(find.textContaining('Complete daily'), findsOneWidget);

    for (var page = 0; page < 3; page++) {
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
    }

    expect(find.text('Phone Number'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Notice Board'), findsOneWidget);
    expect(find.text('Homework'), findsOneWidget);
  });

  testWidgets('abre cursos, passa dados e valida o formulário', (
    tester,
  ) async {
    await tester.pumpWidget(const StellarSchoolApp());

    await tester.tap(find.text('Fluently'));
    await tester.pumpAndSettle();

    for (var page = 0; page < 3; page++) {
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.apps));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Courses'));
    await tester.pumpAndSettle();

    expect(find.text('My courses'), findsOneWidget);
    expect(find.text('English Grammar'), findsOneWidget);

    await tester.tap(find.text('English Grammar'));
    await tester.pumpAndSettle();

    expect(find.text('About this course'), findsOneWidget);
    expect(find.text('Tutor Marina Lopes'), findsOneWidget);

    await tester.ensureVisible(
      find.widgetWithText(ElevatedButton, 'Enroll in this course'),
    );
    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Enroll in this course'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Course enrollment'), findsOneWidget);
    expect(find.text('English Grammar'), findsOneWidget);

    await tester.ensureVisible(
      find.widgetWithText(ElevatedButton, 'Submit enrollment'),
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit enrollment'));
    await tester.pump();

    expect(find.text('Enter your full name.'), findsOneWidget);
    expect(find.text('Enter a valid e-mail.'), findsOneWidget);
    expect(find.text('Enter a valid student ID.'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Yasmin Alves');
    await tester.enterText(fields.at(1), 'yasmin@email.com');
    await tester.enterText(fields.at(2), '20260175');
    await tester.ensureVisible(
      find.widgetWithText(ElevatedButton, 'Submit enrollment'),
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit enrollment'));
    await tester.pump();

    expect(
      find.text('Enrollment in English Grammar submitted!'),
      findsOneWidget,
    );
  });
}
