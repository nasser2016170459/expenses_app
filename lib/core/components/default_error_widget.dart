import 'package:flutter/material.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({super.key, required this.errorMessage, this.onRetry});

  final String errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage, style: AppStyles.paragraphMedium.error),
          if (onRetry != null) ...[
            const SizedBox(height: 8),
            IconButton(
              onPressed: onRetry!,
              icon: const Icon(Icons.refresh, color: AppColors.greyDarker),
            ),
          ]
        ],
      ),
    );
  }
}
