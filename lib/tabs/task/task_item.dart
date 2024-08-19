import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/task/edit_task.dart';
import 'package:todo3/tabs/task/function_firebase.dart';
import 'package:todo3/tabs/task/task_provider.dart';

class TaskItem extends StatefulWidget {
  TaskModel task;
  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isDone;

  @override
  void initState() {
    super.initState();
    isDone = widget.task.isDone;
  }

  void toggleTaskStatus() async {
    setState(() {
      isDone = !isDone;
    });

    widget.task.isDone = isDone;
    await FunctionFirebase.updateTaskInFirebase(widget.task);

    Provider.of<TaskProvider>(context, listen: false).getTask();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        // Provider.of<TaskProvider>(context, listen: false)
        // .updateCurrentTask(widget.task);
        Navigator.of(context).pushNamed(
          EditTask.routeName,
          arguments: widget.task,
        );
      },
      child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                color: isDone ? AppTheme.green : AppTheme.primary,
                margin: EdgeInsetsDirectional.only(end: 10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                        color: isDone ? AppTheme.green : AppTheme.primary),
                  ),
                  Text(
                    widget.task.describtion,
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: toggleTaskStatus,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDone ? Colors.transparent : AppTheme.primary,
                  ),
                  height: 34,
                  width: 69,
                  child: Center(
                    child: isDone
                        ? Text(
                            'Done',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontSize: 22, color: AppTheme.green),
                          )
                        : Image.asset('assets/images/icon_check.png'),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
