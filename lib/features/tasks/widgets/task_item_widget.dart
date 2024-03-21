import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/features/edit_tasks/pages/edit_task.dart';
import 'package:todo_app_new/features/settings_provider.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import 'package:todo_app_new/models/task_model.dart';

import '../../../core/config/app_theme_manager.dart';

class TaskItemWidget extends StatelessWidget {
  TaskModel taskModel;
  TaskItemWidget({required this.taskModel, super.key});

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
                          height: 40,
                          child: Text(
                            'Are you sure ?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        );
                      }),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            FirebaseFunctions.deleteTask(taskModel.id ?? "");
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
              Navigator.pushNamed(context, EditTask.routeName);

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
              height: 80,
              decoration: BoxDecoration(
                color: AppThemeManager.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  taskModel.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: AppThemeManager.primaryColor),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(taskModel.description ?? '',maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: AppThemeManager.primaryColor),),
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
                      DateFormat.yMMMd().format(taskModel.date),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: inactiveColor),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Container(
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
          ],
        ),
      ),
    );
  }
}
