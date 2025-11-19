import 'package:flutter/material.dart';
import 'package:inovola/theme/app_styles.dart';

class LabelWithRequired extends StatelessWidget {
  final String label;
  final bool isRequired;
  final bool showOptional;
  final TextStyle? style;
  final Color? color;
  final String? searchQuery;

  const LabelWithRequired({
    super.key,
    required this.label,
    this.showOptional = false,
    this.isRequired = false,
    this.style,
    this.color,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: style,
          ),
          if (isRequired || showOptional) ...[
            TextSpan(
              text: showOptional ? " (optional)" : " (required)",
              style: AppStyles.paragraphMedium.copyWith(
                fontStyle: FontStyle.italic,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
