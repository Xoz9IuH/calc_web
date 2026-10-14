import 'package:go_router/go_router.dart';

import 'logic/calculator.dart';
import 'logic/currency.dart';
import 'logic/format.dart';
import 'screens/converter_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/home_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/result_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) => const CalculatorScreen(),
      routes: [
        // Вложенный маршрут: итоговый адрес — /calculator/result
        GoRoute(
          path: 'result',
          builder: (context, state) {
            final q = state.uri.queryParameters;
            final result = calculate(q['a'], q['op'], q['b']);
            final expression =
                '${q['a'] ?? '?'} ${q['op'] ?? '?'} ${q['b'] ?? '?'}';
            return switch (result) {
              CalcSuccess(value: final v) => ResultScreen(
                  title: 'Результат вычисления',
                  expression: expression,
                  resultText: formatNumber(v),
                  rawQuery: q,
                  backPath: '/calculator',
                ),
              CalcFailure(message: final m) => ResultScreen(
                  title: 'Результат вычисления',
                  expression: expression,
                  errorMessage: m,
                  rawQuery: q,
                  backPath: '/calculator',
                ),
            };
          },
        ),
      ],
    ),
    GoRoute(
      path: '/converter',
      builder: (context, state) => const ConverterScreen(),
      routes: [
        // Итоговый адрес — /converter/result
        GoRoute(
          path: 'result',
          builder: (context, state) {
            final q = state.uri.queryParameters;
            final result =
                convertCurrency(q['amount'], q['from'], q['to']);
            final expression =
                '${q['amount'] ?? '?'} ${q['from'] ?? '?'} → ${q['to'] ?? '?'}';
            return switch (result) {
              ConvertSuccess(value: final v) => ResultScreen(
                  title: 'Результат конвертации',
                  expression: expression,
                  resultText: formatNumber(v),
                  rawQuery: q,
                  backPath: '/converter',
                ),
              ConvertFailure(message: final m) => ResultScreen(
                  title: 'Результат конвертации',
                  expression: expression,
                  errorMessage: m,
                  rawQuery: q,
                  backPath: '/converter',
                ),
            };
          },
        ),
      ],
    ),
  ],
  // Аналог страницы 404: сюда попадают все неизвестные адреса.
  errorBuilder: (context, state) =>
      NotFoundScreen(location: state.uri.toString()),
);
