# calc_web — ПР1: маршрутизация, формы и URL как состояние

Web-приложение на Flutter: калькулятор и конвертер валют.
Маршрутизация через `go_router`, параметры результата — в адресе (URL как состояние).

## Маршруты

| Адрес | Экран |
|---|---|
| `/` | Главная |
| `/calculator` | Калькулятор (форма) |
| `/calculator/result?a=2&op=%2B&b=3` | Результат вычисления |
| `/converter` | Конвертер валют (форма) |
| `/converter/result?amount=100&from=USD&to=RUB` | Результат конвертации |
| unknown | 404 (`errorBuilder`) |

## Запуск

```sh
flutter pub get
flutter run -d chrome --web-port=5555
```

## Проверки

```sh
flutter analyze
flutter test
flutter build web
```
