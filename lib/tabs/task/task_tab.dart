import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/task/task_item.dart';
import 'package:todo3/tabs/task/task_provider.dart';

class TaskTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            focusDate: taskProvider.selectedDate,
            lastDate: DateTime.now().add(Duration(days: 365)),
            showTimelineHeader: false,
            onDateChange: (selectedDate) {
              taskProvider.changeDate(selectedDate);
              taskProvider.getTask();
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemBuilder: (_, index) => TaskItem(taskProvider.tasks[index]),
              itemCount: taskProvider.tasks.length,
            ),
          ),
        ],
      ),
    );
  }
}
