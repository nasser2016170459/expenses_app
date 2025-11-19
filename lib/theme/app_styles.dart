import 'package:flutter/cupertino.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_fonts.dart';

class AppStyles {
  AppStyles._();

  static TextStyle get displayMedium => const TextStyle(
        fontSize: 64,
        height: 1.2,
        letterSpacing: 0.5,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontSize: 48,
        height: 1.4,
        letterSpacing: 0.22,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      );

  static TextStyle get displayXSmall => const TextStyle(
        fontSize: 36,
        height: 1.4,
        letterSpacing: 0.18,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      );

  /// Heading
  static TextStyle get headingXXLarge => const TextStyle(
        fontSize: 40,
        height: 1.6,
        letterSpacing: 0.4,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get headingXLarge => const TextStyle(
        fontSize: 36,
        height: 1.6,
        letterSpacing: 0.36,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get headingLarge => const TextStyle(
        fontSize: 32,
        height: 1.6,
        letterSpacing: 0.32,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get headingMedium => const TextStyle(
        fontSize: 28,
        height: 1.6,
        letterSpacing: 0.14,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get headingSmall => const TextStyle(
        fontSize: 24,
        height: 1.6,
        letterSpacing: 0.12,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get headingXSmall => const TextStyle(
        fontSize: 20,
        height: 1.6,
        letterSpacing: 0.1,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  /// Label
  static TextStyle get labelLarge => const TextStyle(
        fontSize: 18,
        height: 1.33,
        letterSpacing: 0.45,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontSize: 16,
        height: 1.33,
        letterSpacing: 0.4,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontSize: 14,
        height: 1.8,
        letterSpacing: 0.3,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  static TextStyle get labelXSmall => const TextStyle(
        fontSize: 12,
        height: 1.8,
        letterSpacing: 0.24,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      );

  /// Paragraph
  static TextStyle get paragraphLarge => const TextStyle(
        fontSize: 18,
        height: 1.8,
        letterSpacing: 0.45,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  static TextStyle get paragraphMedium => const TextStyle(
        fontSize: 16,
        height: 1.8,
        letterSpacing: 0.4,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  static TextStyle get paragraphSmall => const TextStyle(
        fontSize: 14,
        height: 1.8,
        letterSpacing: 0.35,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  static TextStyle get paragraphXSmall => const TextStyle(
        fontSize: 12,
        height: 1.8,
        letterSpacing: 0.3,
        fontFamily: AppFonts.manrope,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

}

extension TextStyleExtension on TextStyle {
  TextStyle get primary => copyWith(color: AppColors.primary);

  TextStyle get black => copyWith(color: AppColors.black);
  TextStyle get greyLight => copyWith(color: AppColors.greyLight);
  TextStyle get greyDarker => copyWith(color: AppColors.greyDarker);
  TextStyle get error => copyWith(color: AppColors.error);
  TextStyle get green => copyWith(color: AppColors.green);
}
