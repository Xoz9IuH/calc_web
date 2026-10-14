import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/logic/currency.dart';
import 'package:calc_web/logic/format.dart';

void main() {
  test('конвертация USD -> RUB', () {
    final r = convertCurrency('1', 'USD', 'RUB');
    expect(r, isA<ConvertSuccess>());
    expect((r as ConvertSuccess).value, closeTo(90.0, 1e-9));
  });

  test('конвертация RUB -> USD', () {
    final r = convertCurrency('90', 'RUB', 'USD');
    expect((r as ConvertSuccess).value, closeTo(1.0, 1e-9));
  });

  test('та же валюта возвращает ту же сумму', () {
    final r = convertCurrency('123.45', 'EUR', 'EUR');
    expect((r as ConvertSuccess).value, closeTo(123.45, 1e-9));
  });

  test('нечисловая сумма — ошибка', () {
    final r = convertCurrency('abc', 'USD', 'RUB');
    expect(r, isA<ConvertFailure>());
  });

  test('неизвестная валюта — ошибка', () {
    final r = convertCurrency('10', 'USD', 'XXX');
    expect(r, isA<ConvertFailure>());
  });

  test('отсутствие параметров — ошибка', () {
    expect(convertCurrency(null, 'USD', 'RUB'), isA<ConvertFailure>());
    expect(convertCurrency('10', null, 'RUB'), isA<ConvertFailure>());
    expect(convertCurrency('10', 'USD', null), isA<ConvertFailure>());
  });

  test('форматирование не выводит длинный хвост', () {
    expect(formatNumber(10 / 3), '3.333333');
    expect(formatNumber(4.0), '4');
    expect(formatNumber(2.5), '2.5');
    expect(formatNumber(0.30000000000000004), '0.3');
  });
}
