import 'package:inovola/core/utils/string_helper.dart';

enum Medium {
  MANUAL;

  String? get title => StringHelper.capitalize(name.replaceAll("_", " ").toLowerCase());
}
