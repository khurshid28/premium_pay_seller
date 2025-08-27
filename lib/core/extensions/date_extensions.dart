import 'package:intl/intl.dart';

extension DateFormatUtcPlus5 on DateFormat {
  String formatUtc5(DateTime date) {
    final adjusted = date.toUtc().add(const Duration(hours: 5));
    return format(adjusted);
  }
}