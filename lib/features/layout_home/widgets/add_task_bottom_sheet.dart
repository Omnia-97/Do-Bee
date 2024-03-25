import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_new/features/layout_home/widgets/custom_TextFormField.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import 'package:todo_app_new/models/task_model.dart';

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
              'Add new Task',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              hintText: 'enter your task title',
              controller: titleController,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "please enter your password";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hintText: 'enter your task details',
              controller: descriptionController,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "please enter your password";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select time',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                changeDate(context);
              },
              child: Text(
                chosenTime.toString().substring(0, 10),
                style: theme.textTheme.displayLarge
                    ?.copyWith(fontSize: 28, fontWeight: FontWeight.w100),
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
                onPressed: ()  {
                    TaskModel taskModel = TaskModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      id: '',
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateUtils.dateOnly(chosenTime),
                    );
                    if (formKey.currentState!.validate()){
                      FirebaseFunctions.addTask(taskModel);
                    }
                    Navigator.pop(context);


                },
                child: Text(
                  'Add Task',
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
    DateTime? selectedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
              primary: AppThemeManager.primaryColor,
              background: Color(0xFFDFECDB),
            )),
            child: child!);
      },
      context: context,
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
