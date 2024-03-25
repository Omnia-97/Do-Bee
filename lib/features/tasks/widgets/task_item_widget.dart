import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/features/edit_tasks/pages/edit_task.dart';
import 'package:todo_app_new/features/settings_provider.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import 'package:todo_app_new/models/task_model.dart';

import '../../../core/config/app_theme_manager.dart';

class TaskItemWidget extends StatefulWidget {
  TaskModel taskModel;
  TaskItemWidget({required this.taskModel, super.key});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    final Color inactiveColor = provider.changeCardInactiveColor();
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: .5,
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Dear ${provider.userModel!.fullName}',
                        textAlign: TextAlign.center,
                      ),
                      content: Builder(builder: (context) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          width: 250,
                          height: 50,
                          child: Text(
                            'Are you sure to delete this task ?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        );
                      }),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            FirebaseFunctions.deleteTask(
                                widget.taskModel.id ?? "");
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: AppThemeManager.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: AppThemeManager.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            label: "Delete",
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditTask.routeName,
                  arguments: widget.taskModel);
            },
            icon: Icons.edit,
            label: 'Edit',
            backgroundColor: AppThemeManager.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
      child: Container(
        width: mediaQuery.width,
        height: 115,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: provider.changeCardColor(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 65,
              decoration: BoxDecoration(
                color: widget.taskModel.isDone!
                    ? Colors.green
                    : AppThemeManager.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.taskModel.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: widget.taskModel.isDone!
                          ? Colors.green
                          : AppThemeManager.primaryColor,
                    ),
                  ),
                  Text(
                    widget.taskModel.description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: widget.taskModel.isDone!
                          ? Colors.grey
                          : AppThemeManager.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat.yMMMd().format(widget.taskModel.date),
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: widget.taskModel.isDone!
                                ? Colors.grey
                                : inactiveColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                widget.taskModel.isDone = !widget.taskModel.isDone!;
                FirebaseFunctions.updateTask(widget.taskModel);
              },
              child: widget.taskModel.isDone!
                  ? Text(
                      'Done!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.green,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppThemeManager.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.done_rounded,
                        size: 35,
                        color: AppThemeManager.whiteColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
