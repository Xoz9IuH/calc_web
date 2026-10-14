import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                tooltip: isDark ? 'Светлая тема' : 'Тёмная тема',
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => setThemeMode(
                  isDark ? ThemeMode.light : ThemeMode.dark,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  onPressed: () => context.go('/calculator'),
                  icon: const Icon(Icons.calculate),
                  label: const Text('Калькулятор'),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => context.go('/converter'),
                  icon: const Icon(Icons.currency_exchange),
                  label: const Text('Конвертер валют'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
