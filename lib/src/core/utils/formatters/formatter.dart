import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('yyyy-M-dd').format(date);
  }
}