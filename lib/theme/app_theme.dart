import 'package:flutter/material.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get themeData => ThemeData.from(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.primary,
          secondary: AppColors.black,
          onSecondary: AppColors.primary,
          background: AppColors.primary,
          onBackground: AppColors.primary,
          surface: AppColors.primary,
          onSurface: AppColors.primary,
          error: AppColors.error,
          onError: AppColors.primary,
        ),
        textTheme: TextTheme(
          bodyMedium: AppStyles.paragraphMedium,
          bodySmall: AppStyles.paragraphSmall,
          bodyLarge: AppStyles.paragraphLarge,
          labelLarge: AppStyles.labelLarge,
          labelMedium: AppStyles.labelMedium,
          labelSmall: AppStyles.labelSmall,
        ),
      );

  static OutlineInputBorder defaultFocusedFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
  );

  static OutlineInputBorder defaultNormalFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.greyDarker, width: 1.5),
  );

  static OutlineInputBorder defaultErrorFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.error, width: 1.5),
  );

  static InputDecoration get defaultFieldDecoration => InputDecoration(
        filled: true,
        labelStyle: AppStyles.labelMedium,
        hintStyle: AppStyles.paragraphMedium.greyDarker,
        iconColor: AppColors.primary,
        border: defaultNormalFieldBorder,
        enabledBorder: defaultNormalFieldBorder,
        disabledBorder: defaultNormalFieldBorder,
        focusedBorder: defaultFocusedFieldBorder,
        focusedErrorBorder: defaultErrorFieldBorder,
        errorBorder: defaultErrorFieldBorder,
        fillColor: Colors.transparent,
        hoverColor: Colors.transparent,
        helperStyle: AppStyles.paragraphXSmall,
        errorStyle: AppStyles.paragraphXSmall.error,
        errorMaxLines: 3,
        helperMaxLines: 3,
      );
}
