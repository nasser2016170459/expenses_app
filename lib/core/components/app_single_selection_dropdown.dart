import 'package:flutter/material.dart';
import 'package:inovola/core/utils/image_helper.dart';
import 'package:inovola/theme/app_assets.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class AppSingleSelectionDropdown<T> extends StatelessWidget {
  AppSingleSelectionDropdown({
    super.key,
    required this.options,
    required this.optionTitleBuilder,
    this.selectedOption,
    required this.onSelection,
    this.fillColor = AppColors.primary,
    this.iconHeight,
    this.iconWidth,
    TextStyle? textStyle,
  })  : initialSelection = selectedOption,
        textStyle = textStyle ?? AppStyles.paragraphMedium.black;

  final List<T> options;
  final String Function(T) optionTitleBuilder;
  T? initialSelection;
  final Function(T) onSelection;
  final T? selectedOption;
  final TextStyle textStyle;
  final Color fillColor;
  final double? iconWidth;
  final double? iconHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyLight),
        borderRadius: BorderRadius.circular(4),
        color: fillColor,
      ),
      child: DropdownButton<T>(
        value: initialSelection,
        isExpanded: true,
        hint: Text("Select an option", style: AppStyles.paragraphMedium.greyDarker),
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(4),
        icon: ImageHelper.asset(AppAssets.arrowDownIos, width: iconWidth, height: iconHeight),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        items: options
            .map(
              (T option) => DropdownMenuItem<T>(
                value: option,
                child: Text(optionTitleBuilder(option), style: textStyle),
              ),
            )
            .toList(),
        onChanged: (T? newValue) {
          if (newValue != null) {
            initialSelection = newValue;
            onSelection(newValue);
          }
        },
      ),
    );
  }
}
