import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';
import 'package:inovola/theme/app_theme.dart';
import 'package:intl/intl.dart' as intl;

class AppTextInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final int? minLines;
  final int? maxLines;
  final AutovalidateMode? autoValidateMode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool autoFocus;
  var textDirection = TextDirection.ltr;
  final bool readOnly;
  final ScrollPhysics? scrollPhysics;
  final String? initialValue;
  final Color? fillColor;
  final bool isRequired;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final GlobalKey<FormFieldState>? fieldStateKey;
  final BoxConstraints? labelConstraints;
  final BoxConstraints? fieldConstraints;
  final FocusNode? focusNode;
  final String? searchQuery;
  final BorderRadius? borderRadius;
  final InputBorder? focusedBorder;
  final Color? textColor;
  final VoidCallback? onTap;
  final TextStyle? labelStyle;

  AppTextInputField({
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.minLines = 1,
    this.maxLines = 1,
    this.onChanged,
    this.autoValidateMode,
    this.keyboardType,
    this.inputFormatters,
    this.autofillHints,
    this.autoFocus = false,
    this.readOnly = false,
    this.scrollPhysics,
    this.initialValue,
    this.fillColor,
    this.isRequired = false,
    this.borderColor,
    this.contentPadding,
    this.fieldStateKey,
    super.key,
    this.labelConstraints,
    this.fieldConstraints,
    this.focusNode,
    this.searchQuery,
    this.borderRadius,
    this.focusedBorder,
    this.textColor,
    this.onTap,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Container(
            constraints: labelConstraints,
            child: Text(
              label!,
              style: labelStyle ?? AppStyles.labelMedium.copyWith(color: AppColors.black),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          constraints: fieldConstraints,
          child: Theme(
            data: ThemeData(
              textSelectionTheme: const TextSelectionThemeData(selectionColor: AppColors.greyLight),
            ),
            child: TextFormField(
              onTap: () => onTap?.call(),
              focusNode: focusNode,
              key: fieldStateKey,
              canRequestFocus: true,
              textDirection: textDirection,
              autofocus: autoFocus,
              initialValue: initialValue,
              controller: controller,
              validator: validator,
              autovalidateMode: autoValidateMode,
              obscureText: obscureText,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              autofillHints: autofillHints,
              readOnly: readOnly,
              scrollPhysics: scrollPhysics,
              onChanged: (val) {
                textDirection = intl.Bidi.detectRtlDirectionality(val) ? TextDirection.rtl : TextDirection.ltr;
                onChanged?.call(val);
              },
              onFieldSubmitted: onFieldSubmitted,
              style: AppStyles.paragraphMedium.copyWith(
                color: textColor ?? AppColors.black,
              ),
              minLines: minLines,
              maxLines: maxLines,
              inputFormatters: inputFormatters,
              cursorColor: AppColors.greyDarker,
              decoration: AppTheme.defaultFieldDecoration.copyWith(
                fillColor: fillColor ?? AppColors.greyLight,
                hintText: hintText,
                contentPadding: contentPadding,
                hintStyle: AppStyles.paragraphSmall.greyDarker,
                helperText: helperText,
                enabledBorder: AppTheme.defaultFocusedFieldBorder.copyWith(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: borderColor ?? AppColors.greyLight, width: 1.5),
                ),
                focusedBorder: focusedBorder ??
                    AppTheme.defaultFocusedFieldBorder.copyWith(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: borderColor ?? AppColors.greyLight, width: 1.5),
                    ),
                prefixIcon:
                    prefixIcon != null ? Padding(padding: const EdgeInsets.all(10), child: prefixIcon) : null,
                suffixIcon:
                    suffixIcon != null ? Padding(padding: const EdgeInsets.all(10), child: suffixIcon) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
