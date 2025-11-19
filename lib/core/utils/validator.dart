import 'package:inovola/core/utils/date_time_helper.dart';

class Validator {
  static String? empty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }

    return null;
  }

  static String? date(String? value, String format, {bool required = true}) {
    if (value == null || value.trim().isEmpty) return required ? "This field is required" : null;
    if (DateTimeHelper.parse(value, format) == null) return "Invalid date format";
    return null;
  }

  static String? doubleNumber(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) return required ? "This field is required" : null;
    if (double.tryParse(value) == null) return "Invalid number";
    return null;
  }
}
