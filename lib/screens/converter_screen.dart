import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logic/currency.dart';

const _fromKey = 'conv_from';
const _toKey = 'conv_to';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _from = 'USD';
  String _to = 'RUB';

  @override
  void initState() {
    super.initState();
    _restorePair();
  }

  Future<void> _restorePair() async {
    final prefs = await SharedPreferences.getInstance();
    final from = prefs.getString(_fromKey);
    final to = prefs.getString(_toKey);
    if (!mounted) return;
    setState(() {
      if (from != null && currencies.contains(from)) _from = from;
      if (to != null && currencies.contains(to)) _to = to;
    });
  }

  Future<void> _savePair() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fromKey, _from);
    await prefs.setString(_toKey, _to);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _amountValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введите сумму';
    if (double.tryParse(value.replaceAll(',', '.')) == null) {
      return 'Это не число';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = _amountController.text.trim().replaceAll(',', '.');
    context.go(
      '/converter/result?amount=${Uri.encodeComponent(amount)}'
      '&from=${Uri.encodeComponent(_from)}'
      '&to=${Uri.encodeComponent(_to)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Конвертер валют')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Сумма',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: _amountValidator,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _from,
                    decoration: const InputDecoration(
                      labelText: 'Из валюты',
                      border: OutlineInputBorder(),
                    ),
                    items: currencies
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _from = value);
                      _savePair();
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _to,
                    decoration: const InputDecoration(
                      labelText: 'В валюту',
                      border: OutlineInputBorder(),
                    ),
                    items: currencies
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _to = value);
                      _savePair();
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submit,
                      child: const Text('Конвертировать'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
