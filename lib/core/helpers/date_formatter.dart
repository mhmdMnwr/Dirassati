import 'package:intl/intl.dart';

class DateFormatterHelper {
  static String fomatedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy\nHH:mm').format(date);
  }
}
