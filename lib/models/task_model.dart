import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String title;
  String describtion;
  DateTime date;
  bool isDone;
  String id;

  TaskModel({
    required this.title,
    required this.describtion,
    required this.date,
    this.isDone = false,
    this.id = '',
  });
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title'],
          describtion: json['describtion'],
          date: (json['date'] as Timestamp).toDate(),
          isDone: json['isDone'],
          id: json['id'],
        );

  Map<String, dynamic> toJson() => {
        'title': title,
        'describtion': describtion,
        'date': Timestamp.fromDate(date),
        'isDone': isDone,
        'id': id,
      };
}
