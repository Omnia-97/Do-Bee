import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/config/widgets/container_appBar_widget.dart';
import 'package:todo_app_new/features/tasks/widgets/easy_infinite_date_timeLine_widget.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import '../../../config/constants/app_theme_manager.dart';
import '../../../models/task_model.dart';
import '../../layout_home/widgets/add_task_bottom_sheet.dart';
import '../../settings_provider.dart';
import '../widgets/task_item_widget.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  var focusDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Stack(
            alignment: const Alignment(0, 2.0),
            clipBehavior: Clip.none,
            children: [
              ContainerAppBarWidget(text: 'To Do List'),
              EasyInfiniteDateTimeLine(
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
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseFunctions.getTask(focusDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    const Text('SomeThing went wrong'),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Please try again'),
                    ),
                  ],
                );
              }
              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return const Center(
                  child: Text('No Tasks Added'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItemWidget(
                    taskModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
