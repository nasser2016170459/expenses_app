import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/core/app_logger.dart';
import 'package:intl/intl.dart';
import 'package:inovola/core/models/purchased_item.dart';
import 'package:inovola/core/models/purchased_item_database.dart';
import 'package:inovola/core/models/medium.dart';
import 'package:inovola/core/utils/file_helper.dart';
import 'package:uuid/uuid.dart';
import 'add_expense_event.dart';
import 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final _logger = AppLogger("AddExpenseBloc");

  static const _extensions = {
    FileType.image: ["jpg", "jpeg", "png", "webp"],
  };

  AddExpenseBloc() : super(AddExpenseState()) {
    on<SelectCategory>((event, emit) {
      emit(state.copyWith(
        selectedCategory: event.category,
        isValid: _isValid(
          category: event.category,
          amount: state.amount,
          date: state.selectedDate,
        ),
      ));
    });

    on<UpdateAmount>((event, emit) {
      emit(state.copyWith(
        amount: event.amount,
        isValid: _isValid(
          category: state.selectedCategory,
          amount: event.amount,
          date: state.selectedDate,
        ),
      ));
    });

    on<SelectDate>((event, emit) {
      final formattedDate = DateFormat('MM/dd/yyyy').format(event.date);
      emit(state.copyWith(
        selectedDate: event.date,
        dateText: formattedDate,
        isValid: _isValid(
          category: state.selectedCategory,
          amount: state.amount,
          date: event.date,
        ),
      ));
    });

    on<PickReceipt>((event, emit) async {
      if (state.isPickingFile) return;

      emit(state.copyWith(isPickingFile: true));

      _logger.info("Picking receipt file...");

      final file = await FileHelper.pickSingleFile(
        type: FileType.image,
        extensions: _extensions[FileType.image],
      );

      final extension = file?.extension;
      final sizeInMB = (file?.size ?? 0) / 1024 / 1024;

      if (file == null || extension == null) {
        _logger.info("No file selected");
        emit(state.copyWith(isPickingFile: false));
        return;
      }

      _logger.info("File picked: ${file.name} (${sizeInMB.toStringAsFixed(2)} MB)");

      emit(state.copyWith(
        receipt: file,
        receiptText: file.name,
        isPickingFile: false,
      ));
    });

    on<SaveExpense>((event, emit) async {
      if (!state.isValid) return;

      emit(state.copyWith(isSaving: true));

      try {
        final purchasedItem = PurchasedItem(
          id: const Uuid().v4(),
          price: double.parse(state.amount),
          purchaseDate: state.selectedDate!,
          category: state.selectedCategory,
          medium: Medium.MANUAL,
        );

        final db = PurchasedItemDatabase.instance;
        await db.insertItem(purchasedItem);

        _logger.success("Expense saved successfully");

        emit(AddExpenseSuccess());
      } catch (e) {
        _logger.error("Failed to save expense");
        emit(state.copyWith(
          isSaving: false,
          errorMessage: 'Failed to save expense: $e',
        ));
      }
    });
  }

  bool _isValid({
    required dynamic category,
    required String amount,
    required DateTime? date,
  }) {
    return category != null && amount.isNotEmpty && double.tryParse(amount) != null && date != null;
  }
}
