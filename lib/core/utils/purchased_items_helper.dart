import 'package:inovola/core/models/purchased_item.dart';
import 'package:inovola/core/models/time_period.dart';

extension PurchasedItemsHelper on List<PurchasedItem> {
  DateTime _getDateFromTimePeriod(TimePeriod period) {
    DateTime startDate;
    final now = DateTime.now();
    switch (period) {
      case TimePeriod.LAST_HOUR:
        startDate = now.subtract(const Duration(hours: 1));
        break;
      case TimePeriod.TODAY:
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case TimePeriod.THIS_WEEK:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case TimePeriod.THIS_MONTH:
        startDate = DateTime(now.year, now.month, 1);
        break;
    }
    return startDate;
  }

  List<PurchasedItem> filterByTimePeriod(TimePeriod period) {
    final startDate = _getDateFromTimePeriod(period);
    return where((item) => item.purchaseDate.isAfter(startDate)).toList();
  }
}
