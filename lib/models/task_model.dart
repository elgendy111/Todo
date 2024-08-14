class TaskModel {
  String title;
  String describtion;
  DateTime date;
  bool isDone;
  TaskModel({
    required this.title,
    required this.describtion,
    required this.date,
    this.isDone = false,
  });
}
