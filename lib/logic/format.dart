/// Округление результата до разумного числа знаков,
/// чтобы не выводить 3.3333333333333335.
String formatNumber(double value) {
  if (value.isNaN || value.isInfinite) {
    return value.toString();
  }
  var s = value.toStringAsFixed(6);
  if (s.contains('.')) {
    s = s.replaceAll(RegExp(r'0+$'), '');
    s = s.replaceAll(RegExp(r'\.$'), '');
  }
  if (s == '-0') {
    s = '0';
  }
  return s;
}
