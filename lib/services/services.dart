import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_firebase_task_app/model/task_model.dart';

class taskService {
  // Reference to the Firestore collection
  //The collection name is 'tasks' and access this collection by using the _taskCollection variable

  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection("tasks");

  // method to add new task to the firestore collection

  Future<void> addTask(String name) async {
    // cretae new task with name and current time
    try {
      final task = TaskModel(
        id: '',
        name: name,
        createTime: DateTime.now(),
        updateTime: DateTime.now(),
        isUpdated: false,
      );

      // convert tot task to dart documnet to json
      final Map<String, dynamic> data = task.toJson();

      // add task to collection
      await _taskCollection.add(data);

      print("task added0");
    } catch (e) {
      print(e);
    }
  }

  //method to get all task
  Stream<List<TaskModel>> getTasks() {
    return _taskCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            TaskModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  //method to delete task from firestore
  Future<void> deleteTask(String id) async {
    try {
      await _taskCollection.doc(id).delete();
      print("Task Deleted");
    } catch (e) {
      print(e);
    }
  }

  // method tp upsdate task
  Future<void> updateTask(TaskModel task) async {
    try {
      //convert the task to a map
      final Map<String, dynamic> data = task.toJson();
      await _taskCollection.doc(task.id).update(data);
      print("updated task");
    } catch (e) {
      print(e);
    }
  }
}
