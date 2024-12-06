import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('yyyy-M-dd').format(date);
  }

  static String formatDate2(DateTime? date){
    date ??= DateTime.now();
    return DateFormat.yMMMMd('en_US').format(date);
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  ///email validation
}