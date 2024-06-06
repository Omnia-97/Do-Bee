import 'package:DooBee/features/layout_home/widgets/custom_TextFormField.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:DooBee/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/config/app_theme_manager.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime chosenTime = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appLocalizations = AppLocalizations.of(context)!;
    bool isTextDirectionRTL = Directionality.of(context) == TextDirection.rtl;
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 22,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.addTask,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              hintText: appLocalizations.enterTitle,
              controller: titleController,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.validateTitle;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hintText: appLocalizations.enterDescription,
              controller: descriptionController,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.validateDescription;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 28,
            ),
            if (!isTextDirectionRTL) ...[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  appLocalizations.selectDate,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
            if (isTextDirectionRTL) ...[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  appLocalizations.selectDate,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                changeDate(context);
              },
              child: Text(
                chosenTime.toString().substring(0, 10),
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w100,
                  color: provider.changeCardInactiveColor(),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeManager.primaryColor,
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: () {
                  TaskModel taskModel = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    id: '',
                    title: titleController.text,
                    description: descriptionController.text,
                    date: DateUtils.dateOnly(chosenTime),
                  );
                  if (formKey.currentState!.validate()) {
                    FirebaseFunctions.addTask(taskModel);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  appLocalizations.addTaskButton,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: AppThemeManager.whiteColor,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeDate(BuildContext context) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    DateTime? selectedDate = await showDatePicker(
      context: context,
      locale: Locale(provider.languageCode),
      initialDate: chosenTime,
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
      chosenTime = selectedDate;
      setState(() {});
    }
  }
}
