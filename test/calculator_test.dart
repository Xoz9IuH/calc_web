import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/logic/calculator.dart';

void main() {
  test('сложение', () {
    final r = calculate('2', '+', '3');
    expect(r, isA<CalcSuccess>());
    expect((r as CalcSuccess).value, 5);
  });

  test('вычитание', () {
    final r = calculate('10', '-', '4.5');
    expect((r as CalcSuccess).value, closeTo(5.5, 1e-9));
  });

  test('умножение', () {
    final r = calculate('3', '*', '7');
    expect((r as CalcSuccess).value, 21);
  });

  test('деление', () {
    final r = calculate('7', '/', '2');
    expect((r as CalcSuccess).value, 3.5);
  });

  test('деление на ноль — ошибка', () {
    final r = calculate('5', '/', '0');
    expect(r, isA<CalcFailure>());
    expect((r as CalcFailure).message, contains('ноль'));
  });

  test('нечисловой ввод — ошибка', () {
    final r = calculate('abc', '+', '2');
    expect(r, isA<CalcFailure>());
  });

  test('неизвестная операция — ошибка', () {
    final r = calculate('2', '%', '3');
    expect(r, isA<CalcFailure>());
  });

  test('отсутствие параметра — ошибка', () {
    final r = calculate(null, '+', '3');
    expect(r, isA<CalcFailure>());
    final r2 = calculate('2', null, '3');
    expect(r2, isA<CalcFailure>());
  });

  test('запятая как десятичный разделитель', () {
    final r = calculate('2,5', '+', '2,5');
    expect((r as CalcSuccess).value, closeTo(5.0, 1e-9));
  });
}
