import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:achievers_app/models/task_model.dart';

class TaskController {
  static var categories = {
    "code": {
      'color': 0xFF00A9F1,
      'icon': Icons.code,
    },
    "health": {'color': 0xFFF54336, 'icon': Icons.fitness_center},
    "leisure": {
      'color': 0xFF8BC255,
      'icon': Icons.self_improvement,
    },
    "school": {'color': 0xFF607D8A, 'icon': Icons.assignment},
    "entertainment": {'color': 0xFFFFC02D, 'icon': Icons.headset},
  };

  static final _db = FirebaseFirestore.instance;
  static Future<Task?> getSingleTask(id) async {
    final snapshot = await _db.collection("TasksTest").doc(id).get();
    if (!snapshot.exists) {
      return null;
    }
    var taskData = Task.fromSnapshot(snapshot);
    taskData.color = categories[taskData.category]!["color"];
    taskData.icon = categories[taskData.category]!["icon"];
    return taskData;
  }

  static updateTask(id, update) async {
    DocumentReference docRef  = await _db.collection("TasksTest").doc(id);
    docRef.update(update).then((value) => print("Property updated successfully!")).catchError((error) => print("Failed to update property: $error"));
  }
}
