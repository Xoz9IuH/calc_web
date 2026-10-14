import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calc_web/main.dart';

void main() {
  testWidgets('на главной есть кнопки калькулятора и конвертера',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const CalcApp());
    await tester.pumpAndSettle();
    expect(find.text('Калькулятор'), findsOneWidget);
    expect(find.text('Конвертер валют'), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
