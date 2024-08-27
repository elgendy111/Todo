import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/auth/user_provider.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/task/edit_task.dart';
import 'package:todo3/tabs/task/function_firebase.dart';
import 'package:todo3/tabs/task/task_provider.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  const TaskItem(this.task, {super.key});

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

  void toggleTaskStatus(String userId) async {
    setState(() {
      isDone = !isDone;
    });

    widget.task.isDone = isDone;
    await FunctionFirebase.updateTaskInFirebase(widget.task, userId);

    Provider.of<TaskProvider>(context, listen: false).getTask(userId);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FunctionFirebase.deleteTaskFromFirebase(widget.task.id, userId)
                    .then((_) {
                  Provider.of<TaskProvider>(context, listen: false)
                      .getTask(userId);
                }).catchError((error) {
                  Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: AppTheme.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              EditTask.routeName,
              arguments: widget.task,
            );
          },
          child: Container(
              padding: const EdgeInsets.all(20),
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
                    margin: const EdgeInsetsDirectional.only(end: 10),
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
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: isDone ? AppTheme.green : AppTheme.black,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => toggleTaskStatus(userId),
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
                                style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 22, color: AppTheme.green),
                              )
                            : Image.asset('assets/images/icon_check.png'),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
