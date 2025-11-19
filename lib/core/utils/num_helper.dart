import 'package:intl/intl.dart';

extension NumExtension on num? {
  String get asMoney => NumberFormat("#,##0.##").format(this);
}
