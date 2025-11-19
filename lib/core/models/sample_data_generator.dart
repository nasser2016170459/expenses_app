import 'package:inovola/core/models/medium.dart';
import 'package:inovola/core/models/purchased_item.dart';
import 'package:inovola/core/models/purchased_item_category.dart';
import 'package:inovola/core/models/time_period.dart';
import 'package:uuid/uuid.dart';

class SampleDataGenerator {
  static List<PurchasedItem> generateSampleItems() {
    final now = DateTime.now();
    final items = <PurchasedItem>[];

    // Helper function to get date based on time period
    DateTime getDateForPeriod(TimePeriod period, int offset) {
      switch (period) {
        case TimePeriod.LAST_HOUR:
          return now.subtract(Duration(minutes: 30 + offset * 5));
        case TimePeriod.TODAY:
          return DateTime(now.year, now.month, now.day, 8 + offset, 30);
        case TimePeriod.THIS_WEEK:
          return now.subtract(Duration(days: offset % 7));
        case TimePeriod.THIS_MONTH:
          return DateTime(now.year, now.month, 1 + offset);
      }
    }

    // LAST_HOUR items (5 items)
    items.addAll([
      PurchasedItem(
        id: const Uuid().v4(),
        price: 12.50,
        purchaseDate: getDateForPeriod(TimePeriod.LAST_HOUR, 0),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 45.00,
        purchaseDate: getDateForPeriod(TimePeriod.LAST_HOUR, 1),
        category: PurchasedItemCategory.GAS,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 8.99,
        purchaseDate: getDateForPeriod(TimePeriod.LAST_HOUR, 2),
        category: PurchasedItemCategory.ENTERTAINMENT,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 3.50,
        purchaseDate: getDateForPeriod(TimePeriod.LAST_HOUR, 3),
        category: PurchasedItemCategory.NEWSPAPER,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 15.00,
        purchaseDate: getDateForPeriod(TimePeriod.LAST_HOUR, 4),
        category: PurchasedItemCategory.TRANSPORTATION,
        medium: Medium.MANUAL,
      ),
    ]);

    // TODAY items (10 items)
    items.addAll([
      PurchasedItem(
        id: const Uuid().v4(),
        price: 25.99,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 0),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 120.00,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 1),
        category: PurchasedItemCategory.SHOPPING,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 35.50,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 2),
        category: PurchasedItemCategory.ENTERTAINMENT,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 50.00,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 3),
        category: PurchasedItemCategory.GAS,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 18.75,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 4),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 4.00,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 5),
        category: PurchasedItemCategory.NEWSPAPER,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 22.00,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 6),
        category: PurchasedItemCategory.TRANSPORTATION,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 89.99,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 7),
        category: PurchasedItemCategory.SHOPPING,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 65.00,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 8),
        category: PurchasedItemCategory.ENTERTAINMENT,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 32.50,
        purchaseDate: getDateForPeriod(TimePeriod.TODAY, 9),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
    ]);

    // THIS_WEEK items (10 items)
    items.addAll([
      PurchasedItem(
        id: const Uuid().v4(),
        price: 75.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 1),
        category: PurchasedItemCategory.GAS,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 145.50,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 2),
        category: PurchasedItemCategory.SHOPPING,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 28.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 3),
        category: PurchasedItemCategory.ENTERTAINMENT,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 42.30,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 4),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 3.50,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 5),
        category: PurchasedItemCategory.NEWSPAPER,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 25.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 1),
        category: PurchasedItemCategory.TRANSPORTATION,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 199.99,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 2),
        category: PurchasedItemCategory.SHOPPING,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 55.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 3),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 45.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 4),
        category: PurchasedItemCategory.GAS,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 88.50,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_WEEK, 5),
        category: PurchasedItemCategory.ENTERTAINMENT,
        medium: Medium.MANUAL,
      ),
    ]);

    // THIS_MONTH items (10 items)
    items.addAll([
      PurchasedItem(
        id: const Uuid().v4(),
        price: 1200.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 1),
        category: PurchasedItemCategory.RENT,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 95.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 5),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 250.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 8),
        category: PurchasedItemCategory.SHOPPING,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 75.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 10),
        category: PurchasedItemCategory.GAS,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 150.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 12),
        category: PurchasedItemCategory.ENTERTAINMENT,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 68.99,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 15),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 12.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 18),
        category: PurchasedItemCategory.NEWSPAPER,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 80.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 20),
        category: PurchasedItemCategory.TRANSPORTATION,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 320.00,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 22),
        category: PurchasedItemCategory.SHOPPING,
        medium: Medium.MANUAL,
      ),
      PurchasedItem(
        id: const Uuid().v4(),
        price: 125.75,
        purchaseDate: getDateForPeriod(TimePeriod.THIS_MONTH, 25),
        category: PurchasedItemCategory.GROCERY,
        medium: Medium.MANUAL,
      ),
    ]);

    return items;
  }
}
