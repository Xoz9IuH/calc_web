import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  final String title;
  final String expression;
  final String? resultText;
  final String? errorMessage;
  final Map<String, String> rawQuery;
  final String backPath;

  const ResultScreen({
    super.key,
    required this.title,
    required this.expression,
    this.resultText,
    this.errorMessage,
    required this.rawQuery,
    required this.backPath,
  });

  bool get isError => errorMessage != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expression,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        if (isError)
                          Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  errorMessage!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: Colors.red),
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            '= $resultText',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (rawQuery.isNotEmpty)
                  Text(
                    'Параметры адреса: ${rawQuery.entries.map((e) => '${e.key}=${e.value}').join(', ')}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => context.go(backPath),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Назад к форме'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('На главную'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
