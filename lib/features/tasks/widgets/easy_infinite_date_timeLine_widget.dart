import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: theme.primaryColor),
          ),
          dayNumStyle:
              theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor),
          dayStrStyle:
              theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor),
          monthStrStyle:
              theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor),
        ),
        borderColor: Colors.transparent,
        todayHighlightColor: theme.primaryColor,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: Colors.black26),
          ),
          dayNumStyle:
              theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
          dayStrStyle:
              theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
          monthStrStyle:
              theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
        ),
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          dayNumStyle: theme.textTheme.bodyMedium,
          dayStrStyle: theme.textTheme.bodyMedium,
          monthStrStyle: theme.textTheme.bodyMedium,
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
