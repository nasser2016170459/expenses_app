import 'package:inovola/core/utils/string_helper.dart';

enum TimePeriod {
  TODAY,
  THIS_WEEK,
  THIS_MONTH,
  LAST_HOUR;

  String get title => StringHelper.capitalize(name.replaceAll("_", " "))!;
}
