import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/core/app_routes.dart';
import 'package:inovola/core/components/app_button.dart';
import 'package:inovola/core/components/app_overlay.dart';
import 'package:inovola/core/components/app_single_selection_dropdown.dart';
import 'package:inovola/core/components/app_text_input_field.dart';
import 'package:inovola/core/models/purchased_item_category.dart';
import 'package:inovola/core/utils/image_helper.dart';
import 'package:inovola/core/utils/money_formatter.dart';
import 'package:inovola/core/utils/validator.dart';
import 'package:inovola/features/home/components/add_expense_overlay/bloc/add_expense_bloc.dart';
import 'package:inovola/features/home/components/add_expense_overlay/bloc/add_expense_event.dart';
import 'package:inovola/features/home/components/add_expense_overlay/bloc/add_expense_state.dart';
import 'package:inovola/features/home/components/add_expense_overlay/components/add_category_button.dart';
import 'package:inovola/features/home/components/add_expense_overlay/components/expense_category_item_widget.dart';
import 'package:inovola/theme/app_assets.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class AddExpenseOverlay {
  static Future show({required BuildContext context}) async {
    return AppOverlay.show(
      context: context,
      showCloseButton: false,
      isDismissible: false,
      bodyPadding: EdgeInsets.zero,
      body: BlocProvider(
        create: (context) => AddExpenseBloc(),
        child: const _AddExpenseWidget(),
      ),
    );
  }
}

class _AddExpenseWidget extends StatefulWidget {
  const _AddExpenseWidget();

  @override
  State<_AddExpenseWidget> createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<_AddExpenseWidget> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _receiptController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    _receiptController.dispose();
    super.dispose();
  }

  Future<void> _handleDatePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blue,
              onPrimary: AppColors.primary,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && context.mounted) {
      context.read<AddExpenseBloc>().add(SelectDate(selectedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        if (state.dateText.isNotEmpty && _dateController.text != state.dateText) {
          _dateController.text = state.dateText;
        }

        if (state.receiptText.isNotEmpty && _receiptController.text != state.receiptText) {
          _receiptController.text = state.receiptText;
        }

        if (state is AddExpenseSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Expense saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          AppRoutes.router.pop();
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: InkWell(
                        onTap: () => AppRoutes.router.pop(),
                        child: ImageHelper.asset(AppAssets.back, width: 24, height: 24),
                      ),
                    ),
                    Center(
                      child: Text("Add Expense", style: AppStyles.labelLarge),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text("Categories", style: AppStyles.labelMedium),
                const SizedBox(height: 8),
                SizedBox(
                  height: 45,
                  child: AppSingleSelectionDropdown<PurchasedItemCategory>(
                    options: PurchasedItemCategory.values,
                    selectedOption: state.selectedCategory,
                    optionTitleBuilder: (option) => option.title!,
                    onSelection: (option) {
                      context.read<AddExpenseBloc>().add(SelectCategory(option));
                    },
                    fillColor: AppColors.greyLight,
                    iconHeight: 28,
                    iconWidth: 28,
                  ),
                ),
                const SizedBox(height: 12),
                AppTextInputField(
                  controller: _amountController,
                  label: "Amount",
                  hintText: "\$50,000",
                  keyboardType: TextInputType.number,
                  inputFormatters: [MoneyFormatter(decimalDigits: 2)],
                  contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  validator: Validator.doubleNumber,
                  onChanged: (value) {
                    context.read<AddExpenseBloc>().add(UpdateAmount(value));
                  },
                ),
                const SizedBox(height: 12),
                AppTextInputField(
                  controller: _dateController,
                  label: "Date",
                  hintText: "MM/DD/YYYY",
                  readOnly: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  validator: (value) => Validator.date(value, 'MM/dd/yyyy'),
                  suffixIcon: ImageHelper.asset(
                    AppAssets.calendar,
                    color: AppColors.black,
                    width: 16,
                    height: 16,
                  ),
                  onTap: () => _handleDatePicker(context),
                ),
                const SizedBox(height: 12),
                AppTextInputField(
                  controller: _receiptController,
                  label: "Attach Receipt",
                  hintText: "upload image",
                  readOnly: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  validator: (value) => Validator.empty(value),
                  suffixIcon: ImageHelper.asset(
                    AppAssets.camera,
                    color: AppColors.black,
                    width: 16,
                    height: 16,
                  ),
                  onTap: state.isPickingFile
                      ? null
                      : () {
                          context.read<AddExpenseBloc>().add(PickReceipt());
                        },
                ),
                const SizedBox(height: 16),
                Text("Categories", style: AppStyles.labelLarge),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                  child: Wrap(
                    spacing: 27,
                    runSpacing: 32,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.up,
                    alignment: WrapAlignment.start,
                    children: [
                      ...PurchasedItemCategory.values.map(
                        (e) => ExpenseCategoryItemWidget(category: e),
                      ),
                      AddCategoryButton(onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                AppButton.primary(
                  title: state.isSaving ? "Saving..." : "Save",
                  onPressed: state.isSaving
                      ? () {}
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AddExpenseBloc>().add(SaveExpense());
                          }
                        },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
