import 'package:intl/intl.dart';

extension CurrencyRupiahStringExtension on int {
  String get intToFormatRupiah {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(this);
  }
}
