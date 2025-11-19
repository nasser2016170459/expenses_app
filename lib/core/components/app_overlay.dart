import 'package:flutter/material.dart';
import 'package:inovola/core/app_routes.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class AppOverlay {
  static Future show({
    required Widget body,
    String? title,
    TextStyle? titleStyle,
    double? maxWidth,
    double? maxHeight,
    double? minHeight,
    double? minWidth,
    bool showCloseButton = true,
    bool isDismissible = false,
    bool isScrollable = true,
    EdgeInsetsGeometry bodyPadding = const EdgeInsets.symmetric(horizontal: 24.0),
    required BuildContext context,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.black.withOpacity(0.2),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.9,
              maxWidth: maxWidth ?? MediaQuery.of(context).size.width,
              minHeight: minHeight ?? 0,
              minWidth: minWidth ?? 0,
            ),
            child: _AppOverlayWidget(
              body: body,
              title: title,
              titleStyle: titleStyle,
              showCloseButton: showCloseButton,
              isScrollable: isScrollable,
              bodyPadding: bodyPadding,
            ),
          ),
        );
      },
    );
  }
}

class _AppOverlayWidget extends StatelessWidget {
  const _AppOverlayWidget({
    required this.body,
    required this.title,
    required this.titleStyle,
    required this.showCloseButton,
    required this.isScrollable,
    required this.bodyPadding,
  });

  final Widget body;
  final String? title;
  final TextStyle? titleStyle;
  final bool showCloseButton;
  final bool isScrollable;
  final EdgeInsetsGeometry bodyPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(12),
      child: SingleChildScrollView(
        physics: isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: bodyPadding,
          child: Column(
            children: [
              if (title != null || showCloseButton) ...[
                const SizedBox(height: 16),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                  contentPadding: EdgeInsets.zero,
                  title: title != null ? Text(title!, style: titleStyle ?? AppStyles.headingSmall.black) : null,
                  trailing: showCloseButton
                      ? IconButton(
                          icon: const Icon(Icons.close, color: AppColors.black),
                          onPressed: () {
                            AppRoutes.router.pop();
                          },
                        )
                      : null,
                ),
                const SizedBox(height: 24),
              ],
              body,
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
