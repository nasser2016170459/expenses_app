class StringHelper {
  static String? capitalize(String? value) {
    if (value == null) return null;
    if (value.trim().isEmpty) return value;
    return value.split(' ').map(capitalizeFirst).join(' ');
  }

  static String? capitalizeFirst(String s) {
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
