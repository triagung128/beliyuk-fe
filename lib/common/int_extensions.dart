import 'package:intl/intl.dart';

extension IntExtensions on int {
  String get intToFormatRupiah {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(this);
  }

  String get convertUnitWeight {
    if (this < 1000) {
      return '$this gr';
    } else {
      final double weight = this / 1000;
      return '${weight.toStringAsFixed(weight.truncateToDouble() == weight ? 0 : 1)} kg';
    }
  }
}
