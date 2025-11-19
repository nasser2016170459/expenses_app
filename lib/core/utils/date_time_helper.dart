import 'package:intl/intl.dart';

class DateTimeHelper {
  static const shortDate = "MMM, dd, yy";
  static DateTime? parse(String? value, String format) {
    if (value == null || value.trim().isEmpty || value.length != format.length) return null;
    try {
      return DateFormat(format).parseLoose(value);
    } catch (e) {
      return null;
    }
  }

  static String? format(DateTime? value, String format) {
    if (value == null) return null;
    try {
      return DateFormat(format).format(value);
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeFormatter on DateTime {
  String get asShortDate => DateTimeHelper.format(this, DateTimeHelper.shortDate) ?? "";
}
