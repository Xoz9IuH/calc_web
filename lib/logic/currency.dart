/// Курсы заданы константами: сколько рублей стоит одна единица валюты.
/// Базовая валюта — RUB.
const Map<String, double> currencyRates = {
  'RUB': 1.0,
  'USD': 90.0,
  'EUR': 98.0,
  'CNY': 12.5,
  'KZT': 0.19,
  'BYN': 27.0,
};

/// Валюты для выпадающих списков (не менее пяти по заданию).
const List<String> currencies = ['RUB', 'USD', 'EUR', 'CNY', 'KZT', 'BYN'];

sealed class ConvertResult {
  const ConvertResult();
}

class ConvertSuccess extends ConvertResult {
  final double value;
  const ConvertSuccess(this.value);
}

class ConvertFailure extends ConvertResult {
  final String message;
  const ConvertFailure(this.message);
}

ConvertResult convertCurrency(String? rawAmount, String? rawFrom, String? rawTo) {
  if (rawAmount == null ||
      rawFrom == null ||
      rawTo == null ||
      rawAmount.trim().isEmpty ||
      rawFrom.trim().isEmpty ||
      rawTo.trim().isEmpty) {
    return const ConvertFailure('В адресе отсутствуют обязательные параметры');
  }

  final amount = double.tryParse(rawAmount.replaceAll(',', '.'));
  if (amount == null) {
    return const ConvertFailure('В адресе передана не числовая сумма');
  }

  final fromRate = currencyRates[rawFrom];
  final toRate = currencyRates[rawTo];
  if (fromRate == null || toRate == null) {
    return const ConvertFailure('Неизвестная валюта');
  }
  if (fromRate <= 0 || toRate <= 0) {
    return const ConvertFailure('Некорректный курс валюты');
  }

  final inRub = amount * fromRate;
  return ConvertSuccess(inRub / toRate);
}
