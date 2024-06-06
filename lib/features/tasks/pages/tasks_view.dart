import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_theme_manager.dart';
import '../../../core/widgets/container_appBar_widget.dart';
import '../../../models/task_model.dart';
import '../../login/pages/login_screen.dart';
import '../../settings_provider.dart';
import '../widgets/task_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var appLocalization = AppLocalizations.of(context)!;
    bool isTextDirectionRTL = Directionality.of(context) == TextDirection.rtl;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Stack(
            alignment: const Alignment(0, 2.0),
            clipBehavior: Clip.none,
            children: [
              isTextDirectionRTL?Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ContainerAppBarWidget(text: appLocalization.todoList),
                  Padding(
                    padding: const EdgeInsets.only(left: 42),
                    child: Text(
                      appLocalization.logout,
                      style: TextStyle(color: provider.changeLogoutColor()),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.disconnect();
                      FirebaseFunctions.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.routeName, (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.logout,
                        color: provider.changeLogoutColor(),
                      ),
                    ),
                  ),
                ],
              ):
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  ContainerAppBarWidget(text: appLocalization.todoList),
                  Padding(
                    padding: const EdgeInsets.only(right: 42),
                    child: Text(
                      appLocalization.logout,
                      style: TextStyle(color: provider.changeLogoutColor()),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.disconnect();
                      FirebaseFunctions.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.routeName, (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.logout,
                        color:provider.changeLogoutColor(),
                      ),
                    ),
                  ),
                ],
              ),
              EasyInfiniteDateTimeLine(
                locale: provider.languageCode,
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
                     Text(appLocalization.isError),
                    ElevatedButton(
                      onPressed: () {},
                      child:  Text(appLocalization.tryAgain),
                    ),
                  ],
                );
              }
              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return  Center(
                  child: Text(appLocalization.noTasks, style: TextStyle(color: provider.changeCardTextColor()),),
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
