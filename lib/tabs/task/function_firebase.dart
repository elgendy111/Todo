import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo3/models/task_model.dart';

class FunctionFirebase {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (docsnapshot, _) =>
                TaskModel.fromJson(docsnapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

  static Future<void> addTasksToFirebase(TaskModel task) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    DocumentReference<TaskModel> docRef = tasksCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<TaskModel>> getAllTaskFromFirebase() async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirebase(String taskId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    return tasksCollection.doc(taskId).delete();
  }

  static Future<void> updateTaskInFirebase(TaskModel task) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    return tasksCollection.doc(task.id).update(task.toJson());
  }

  static Future<void> changeTaskInFirebase(TaskModel task) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    return tasksCollection.doc(task.id).set(task);
  }
}
