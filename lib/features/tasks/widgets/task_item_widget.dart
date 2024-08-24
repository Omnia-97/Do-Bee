import 'package:DooBee/features/edit_tasks/pages/edit_task.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:DooBee/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    var appLocalization = AppLocalizations.of(context)!;
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
                      backgroundColor: provider.changeCardColor(),
                      title: Text(
                        '${appLocalization.dear} ${provider.userModel!.fullName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: provider.changeCardInactiveColor()),
                      ),
                      content: Builder(builder: (context) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          width: 250,
                          height: 50,
                          child: Text(
                            appLocalization.deleteAlert,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: provider.changeCardInactiveColor()),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: provider.changeCardColor(),
                          ),
                          child: Text(
                            appLocalization.yes,
                            style: const TextStyle(
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: provider.changeCardColor(),
                          ),
                          child: Text(
                            appLocalization.cancel,
                            style: const TextStyle(
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
            label: appLocalization.delete,
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
            label: appLocalization.edit,
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
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 20,
                        color: widget.taskModel.isDone!
                            ? Colors.grey
                            : provider.changeCardInactiveColor(),
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
                      appLocalization.done,
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
