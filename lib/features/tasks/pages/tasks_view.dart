import 'package:DooBee/features/tasks/widgets/text_form_feild_search.dart';
import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_theme_manager.dart';
import '../../../models/task_model.dart';
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
    var appLocalization = AppLocalizations.of(context)!;
    bool isTextDirectionRTL = Directionality.of(context) == TextDirection.rtl;
    return Padding(
      padding: EdgeInsets.only(left: 36.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 72.h,
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              width: 45.w,
              height: 45.h,
              margin: EdgeInsets.only(right: 21.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD9D9D9).withOpacity(
                  0.25,
                ),
              ),
              child: Align(
                child: SvgPicture.asset(
                  "assets/images/ic_notify.svg",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Text(
            "Welcome Back,",
            textAlign: TextAlign.start,
            style: theme.textTheme.titleLarge?.copyWith(
              color: const Color(0xFF898989),
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            textAlign: TextAlign.start,
            provider.userModel?.fullName ?? "Unknown",
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppThemeManager.blackColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
              width: 278.w, height: 44.h, child: CustomTextFormFieldSearch()),
          SizedBox(
            height: 25.h,
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
                  border: Border.all(color: AppThemeManager.primaryPurpleColor),
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
              todayHighlightColor: AppThemeManager.primaryPurpleColor,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: provider.changeCardColor(),
                  border: Border.all(color: AppThemeManager.primaryPurpleColor),
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
                        child: Text(appLocalization.tryAgain),
                      ),
                    ],
                  );
                }
                var tasks =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      appLocalization.noTasks,
                      style: TextStyle(color: provider.changeCardTextColor()),
                    ),
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
      ),
    );
  }
}
