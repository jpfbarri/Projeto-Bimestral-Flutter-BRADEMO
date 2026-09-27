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
}
