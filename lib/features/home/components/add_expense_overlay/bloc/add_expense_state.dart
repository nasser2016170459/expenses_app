import 'package:file_picker/file_picker.dart';
import 'package:inovola/core/models/purchased_item_category.dart';

class AddExpenseState {
  final PurchasedItemCategory? selectedCategory;
  final String amount;
  final DateTime? selectedDate;
  final PlatformFile? receipt;
  final bool isSaving;
  final bool isValid;
  final String? errorMessage;
  final String dateText;
  final String receiptText;
  final bool isPickingFile;

  AddExpenseState({
    this.selectedCategory,
    this.amount = '',
    this.selectedDate,
    this.receipt,
    this.isSaving = false,
    this.isValid = false,
    this.errorMessage,
    this.dateText = '',
    this.receiptText = '',
    this.isPickingFile = false,
  });

  AddExpenseState copyWith({
    PurchasedItemCategory? selectedCategory,
    String? amount,
    DateTime? selectedDate,
    PlatformFile? receipt,
    bool? isSaving,
    bool? isValid,
    String? errorMessage,
    String? dateText,
    String? receiptText,
    bool? isPickingFile,
  }) {
    return AddExpenseState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      amount: amount ?? this.amount,
      selectedDate: selectedDate ?? this.selectedDate,
      receipt: receipt ?? this.receipt,
      isSaving: isSaving ?? this.isSaving,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
      dateText: dateText ?? this.dateText,
      receiptText: receiptText ?? this.receiptText,
      isPickingFile: isPickingFile ?? this.isPickingFile,
    );
  }
}

class AddExpenseSuccess extends AddExpenseState {}
