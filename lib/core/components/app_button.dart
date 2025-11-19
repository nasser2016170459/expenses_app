import 'package:flutter/material.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color? borderColor;
  final bool isEnabled;
  final bool isLoading;
  final Function onPressed;
  final double minWidth;
  final double height;
  final double borderRadius;
  final TextStyle textStyle;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final bool isExpanded;
  final EdgeInsetsGeometry? padding;

  AppButton({
    required this.title,
    required this.onPressed,
    required this.color,
    required this.borderColor,
    this.isEnabled = true,
    this.isLoading = false,
    this.minWidth = double.infinity,
    this.height = 56,
    this.borderRadius = 16,
    TextStyle? textStyle,
    this.trailingIcon,
    this.leadingIcon,
    this.padding,
    super.key,
  })  : textStyle = textStyle ?? AppStyles.labelXSmall,
        isExpanded = false;

  AppButton.primary({
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.minWidth = double.infinity,
    this.height = 40,
    TextStyle? textStyle,
    bool? isEnabled,
    this.padding,
    super.key,
  })  : textStyle = textStyle ?? AppStyles.labelMedium.primary,
        color = AppColors.blue,
        borderColor = AppColors.blue,
        borderRadius = 8,
        trailingIcon = null,
        leadingIcon = null,
        isEnabled = isEnabled ?? true,
        isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      elevation: 0,
      height: height,
      minWidth: minWidth,
      hoverElevation: 0,
      color: color,
      hoverColor: color.withOpacity(0),
      textColor: textStyle.color,
      disabledColor: AppColors.greyDarker,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: isEnabled ? (borderColor ?? color) : AppColors.blue),
      ),
      onPressed: isEnabled
          ? isLoading
              ? () {}
              : () => onPressed()
          : null,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: textStyle.color,
                valueColor: AlwaysStoppedAnimation(textStyle.color),
                strokeWidth: 3,
              ),
            )
          : leadingIcon != null || trailingIcon != null
              ? isExpanded
                  ? Container(
                      padding: padding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (leadingIcon != null) ...[
                            leadingIcon!,
                            const SizedBox(width: 8),
                          ],
                          Expanded(child: Text(title, style: textStyle)),
                          if (trailingIcon != null) ...[
                            const SizedBox(width: 8),
                            trailingIcon!,
                          ],
                        ],
                      ),
                    )
                  : Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (leadingIcon != null) leadingIcon!,
                        Text(title, style: textStyle),
                        if (trailingIcon != null) trailingIcon!,
                      ],
                    )
              : Text(title, style: textStyle),
    );
  }
}
