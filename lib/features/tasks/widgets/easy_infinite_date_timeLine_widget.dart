import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/config/constants/app_theme_manager.dart';
import 'package:todo_app_new/features/settings_provider.dart';

class EasyInfiniteDateTimeLineWidget extends StatefulWidget {
  const EasyInfiniteDateTimeLineWidget({super.key});

  @override
  State<EasyInfiniteDateTimeLineWidget> createState() =>
      _EasyInfiniteDateTimeLineWidgetState();
}

class _EasyInfiniteDateTimeLineWidgetState
    extends State<EasyInfiniteDateTimeLineWidget> {
  var focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return EasyInfiniteDateTimeLine(
      showTimelineHeader: false,
      timeLineProps: const EasyTimeLineProps(
        separatorPadding: 20,
      ),
      firstDate: DateTime(2024),
      focusDate: focusDate,
      lastDate: DateTime(2025),
      dayProps: EasyDayProps(
        width: 58,
        height: 79,
        todayHighlightStyle: TodayHighlightStyle.none,
        todayStyle: DayStyle(
          decoration: BoxDecoration(
            color: provider.changeCardColor(),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppThemeManager.primaryColor),
          ),
          dayNumStyle: theme.textTheme.bodyMedium!.copyWith(
            color: provider.changeCardTextColor(),
          ),
          dayStrStyle: theme.textTheme.bodyMedium!.copyWith(
            color: provider.changeCardTextColor(),
          ),
          monthStrStyle: theme.textTheme.bodyMedium!.copyWith(
            color: provider.changeCardTextColor(),
          ),
        ),
        borderColor: Colors.transparent,
        todayHighlightColor: AppThemeManager.primaryColor,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: provider.changeCardColor(),
            border: Border.all(color: AppThemeManager.primaryColor),
          ),
          dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
            color: provider.changeCardTextColor(),
          ),
          dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
            color: provider.changeCardTextColor(),
          ),
          monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
            color: provider.changeCardTextColor(),
          ),
        ),
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: provider.changeCardColor(),
          ),
          dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
            color: provider.changeCardInactiveColor(),
          ),
          dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
            color: provider.changeCardInactiveColor(),
          ),
          monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
            color: provider.changeCardInactiveColor(),
          ),
        ),
      ),
      onDateChange: (selectedDate) {
        setState(
          () {
            focusDate = selectedDate;
          },
        );
      },
    );
  }
}
