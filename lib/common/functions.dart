import 'dart:math' as math;

String metricsConverter(int count) {
  if (count == 0) {
    return '0';
  }
  final int digits = (math.log(count) ~/ math.log(10)) + 1;
  String res = count.toString();

  if (digits == 4 || digits == 5) {
    res = '${(count / 1000).toStringAsFixed(2)}k';
  } else if (digits == 6) {
    res = '${(count / 1000).round()}k';
  } else if (digits == 7 || digits == 8) {
    res = '${(count / 1000000).toStringAsFixed(2)}M';
  } else if (digits == 9) {
    res = '${(count / 1000000).round()}M';
  }

  return res;
}
