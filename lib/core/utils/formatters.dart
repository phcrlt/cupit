import 'package:intl/intl.dart';

class AppFormatters {
  static final NumberFormat _balanceFormatter = NumberFormat.currency(
    locale: 'ru_RU',
    symbol: '₽',
    decimalDigits: 0,
  );

  static final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy', 'ru_RU');

  static String formatBalance(double amount) {
    return _balanceFormatter.format(amount);
  }

  static String formatTransactionAmount(double amount) {
    final sign = amount >= 0 ? '+' : '-';
    return '$sign${_balanceFormatter.format(amount.abs())}';
  }

  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }
}
