import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import 'package:todo_app_new/models/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/config/app_theme_manager.dart';
import '../../layout_home/widgets/custom_TextFormField.dart';
import '../../settings_provider.dart';

class EditTask extends StatefulWidget {
  static String routeName = 'Edit Task';

  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime chosenTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    var appLocalization = AppLocalizations.of(context)!;
    bool isTextDirectionRTL = Directionality.of(context) == TextDirection.rtl;
    return Drawer(
      child: Form(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Scaffold(),
            Container(
              width: mediaQuery.width,
              height: mediaQuery.height * 0.23,
              color: AppThemeManager.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 28,
                  left: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: provider.changeLogoutColor(),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(appLocalization.todoList,
                        style: theme.textTheme.titleLarge),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 140,
              left: 32,
              child: Container(
                width: 352,
                height: 617,
                decoration: BoxDecoration(
                  color: provider.changeCardColor(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        appLocalization.editTask,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: provider.changeEditText(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        hintText: appLocalization.enterTitle,
                        //controller: titleController..text = task.title ??'',
                        initialValue: task.title,
                        onChanged: (value) {
                          task.title = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        hintText: appLocalization.enterDescription,
                        //controller: descriptionController..text = task.description ??'',
                        initialValue: task.description,
                        onChanged: (value) {
                          task.description = value;
                        },
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      if (isTextDirectionRTL) ...[
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            appLocalization.selectDate,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                      if (!isTextDirectionRTL) ...[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            appLocalization.selectDate,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          task.date = await changeDate(context, task.date);
                          setState(() {});
                        },
                        child: Text(
                          task.date.toString().substring(0, 10),
                          style: theme.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w100,
                              color: provider.changeCardInactiveColor()),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      InkWell(
                        onTap: () async {
                          await FirebaseFunctions.updateTask(task);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 255,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppThemeManager.primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            appLocalization.saveEdit,
                            style: theme.textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeDate(BuildContext context, DateTime time) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    DateTime? selectedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.highContrastDark(
              primary: AppThemeManager.primaryColor,
              brightness: provider.themeMode == ThemeMode.light
                  ? Brightness.light
                  : Brightness.dark,
            )),
            child: child!);
      },
      initialDate:
          DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 360),
      ),
      selectableDayPredicate: (day) =>
          day !=
          DateTime.now().add(
            const Duration(days: 2),
          ),
    );

    if (selectedDate != null) {
      time = DateUtils.dateOnly(selectedDate);
      setState(() {});
    }
    return time;
  }
}
