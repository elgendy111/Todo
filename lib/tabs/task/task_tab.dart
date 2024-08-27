import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/auth/user_provider.dart';
import 'package:todo3/tabs/task/task_item.dart';
import 'package:todo3/tabs/task/task_provider.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  bool shouldGetTask = true;
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    double ScreenHight = MediaQuery.of(context).size.height;
    if (shouldGetTask) {
      final userId = Provider.of<UserProvider>(context).currentUser!.id;
      taskProvider.getTask(userId);
      shouldGetTask = false;
    }
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: ScreenHight * 0.17,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              top: 40,
              start: 20,
              child: Text(
                'To Do List',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 22, color: AppTheme.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenHight * 0.1),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                focusDate: taskProvider.selectedDate,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                showTimelineHeader: false,
                onDateChange: (selectedDate) {
                  taskProvider.changeDate(selectedDate);
                  taskProvider.getTask(
                      Provider.of<UserProvider>(context, listen: false)
                          .currentUser!
                          .id);
                },
                activeColor: AppTheme.white,
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayNumDayStr,
                  height: 90,
                  width: 60,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    dayNumStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                    dayStrStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    dayNumStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                    dayStrStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (_, index) => TaskItem(taskProvider.tasks[index]),
            itemCount: taskProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
