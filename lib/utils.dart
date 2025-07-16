// lib/utils.dart
String convertToChineseNumber(int num) {
  const chineseNumbers = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九'];
  const chineseTens = ['', '十', '二十', '三十', '四十', '五十', '六十', '七十', '八十', '九十'];

  if (num < 10) {
    return chineseNumbers[num];
  } else if (num < 100) {
    int ten = num ~/ 10;
    int unit = num % 10;
    return '${chineseTens[ten]}${unit == 0 ? '' : chineseNumbers[unit]}';
  }
  return num.toString();
}
