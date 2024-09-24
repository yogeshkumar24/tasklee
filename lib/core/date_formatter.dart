import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateOnly(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String formatDateOnlyFromMilliseconds(int timeInMilliseconds) {
    return DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(timeInMilliseconds));
  }
}
