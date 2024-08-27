import 'package:flutter/material.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/task/function_firebase.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  TaskModel? currentTask;
  DateTime selectedDate = DateTime.now();

  Future<void> getTask(String userId) async {
    List<TaskModel> allTasks =
        await FunctionFirebase.getAllTaskFromFirebase(userId);
    tasks = allTasks
        .where((task) =>
            task.date.day == selectedDate.day &&
            task.date.month == selectedDate.month &&
            task.date.year == selectedDate.year)
        .toList();
    notifyListeners();
  }

  void changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> updateCurrentTask(TaskModel updatedTask, String userId) async {
    if (currentTask != null) {
      await FunctionFirebase.updateTaskInFirebase(updatedTask, userId);
      getTask(userId);
      notifyListeners();
    }
  }
}
