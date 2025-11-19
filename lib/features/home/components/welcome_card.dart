import 'package:flutter/material.dart';
import 'package:inovola/core/components/app_single_selection_dropdown.dart';
import 'package:inovola/core/models/time_period.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class WelcomeCardWidget extends StatelessWidget {
  const WelcomeCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTimePeriodChanged,
    required this.timePeriods,
    this.selectedTimePeriod,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final Function(TimePeriod) onTimePeriodChanged;
  final List<TimePeriod> timePeriods;
  final TimePeriod? selectedTimePeriod;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.blue,
        gradient: LinearGradient(
          colors: [
            AppColors.blueLight,
            AppColors.blue,
            AppColors.blueLighter.withOpacity(0.5),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title, style: AppStyles.labelSmall.primary),
        subtitle: Text(subtitle, style: AppStyles.labelMedium.primary),
        trailing: SizedBox(
          width: 120,
          height: 30,
          child: AppSingleSelectionDropdown<TimePeriod>(
            options: timePeriods,
            optionTitleBuilder: (option) => option.title,
            selectedOption: selectedTimePeriod,
            onSelection: (option) => onTimePeriodChanged(option),
            textStyle: AppStyles.paragraphXSmall.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
