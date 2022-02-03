import 'package:intl/intl.dart';

class Formatter {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );

  Formatter._();

  static String formatCurrency(double value) {
    return _currencyFormat.format(value);
  }
}
