import 'package:file_picker/file_picker.dart';
import 'package:inovola/core/models/purchased_item_category.dart';

abstract class AddExpenseEvent {}

class SelectCategory extends AddExpenseEvent {
  final PurchasedItemCategory category;

  SelectCategory(this.category);
}

class UpdateAmount extends AddExpenseEvent {
  final String amount;

  UpdateAmount(this.amount);
}

class SelectDate extends AddExpenseEvent {
  final DateTime date;

  SelectDate(this.date);
}

class PickReceipt extends AddExpenseEvent {}

class SelectReceipt extends AddExpenseEvent {
  final PlatformFile image;
  final String fileName;

  SelectReceipt(this.image, this.fileName);
}

class SaveExpense extends AddExpenseEvent {}
