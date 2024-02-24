import 'package:flutter/material.dart';
import 'package:todo_app_new/config/widgets/container_appBar_widget.dart';
import 'package:todo_app_new/features/tasks/widgets/easy_infinite_date_timeLine_widget.dart';

import '../widgets/task_item_widget.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: Stack(
            alignment: const Alignment(0, 2.0),
            clipBehavior: Clip.none,
            children: [
              ContainerAppBarWidget(text: 'To Do List'),
              const EasyInfiniteDateTimeLineWidget(),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: List.generate(
              10,
              (index) => const TaskItemWidget(),
            ),
          ),
        )
      ],
    );
  }
}
