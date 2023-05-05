import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';

class Db {
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
  static Future<List<Task>> allTasks() async {
    final snapshot = await _db.collection("tasks").get();
    var taskData =
        snapshot.docs.map((task) => Task.fromSnapshot(task)).toList();

    taskData = getTasks(taskData);
    print(taskData);
    return taskData;
  }

  static Future<List<Day>> getWeekdayCounts() async {
    // Initialize an empty Map to count occurrences of each weekday
    Map<String, int> counts = {
      "Mon": 0,
      "Tue": 0,
      "Wed": 0,
      "Thu": 0,
      "Fri": 0,
      "Sat": 0,
      "Sun": 0,
    };
    var data = await allTasks();
    // Iterate over each date and increment the count for its weekday
    for (Task dateString in data) {
      print(dateString.date.split('/').reversed.join('-'));
      DateTime date =
          DateTime.parse("${dateString.date.split('/').reversed.join('-')}");
      String weekday = DateFormat("E").format(date);
      counts[weekday] = (counts[weekday] ?? 0) + 1;
    }

    // Convert the Map to an array of Day objects and return it
    return counts.entries
        .map((entry) => Day(name: entry.key, completed: entry.value))
        .toList();
  }

  static Future<List<Task>> filterTasks(propertyName, propertyValue) async {
    final snapshot = await _db.collection("tasks").where(propertyName, isEqualTo: propertyValue).get();
    var taskData =
        snapshot.docs.map((task) => Task.fromSnapshot(task)).toList();

    taskData = getTasks(taskData);
    print(taskData);
    return taskData;
  }

  static Future<HomeVariable> getHomeVariables() async {
    var tasks =  await allTasks();
    var completed = await filterTasks('completed', true);
    final nbr_of_tasks = tasks.length;
    final nbr_of_completed_tasks = completed.length;

    final percentage = (nbr_of_completed_tasks/nbr_of_tasks) * 100;

    final vars = HomeVariable(percentage: percentage, totalTasks: nbr_of_tasks, completed: nbr_of_completed_tasks); 

    return vars;
  
  }

  static List<Task> getTasks(List<Task> theTasks) {
    var newAsksArray = theTasks.map((Task task) {
      task.color = categories[task.category]!["color"];
      task.icon = categories[task.category]!["icon"];
      print("compute-----------");
      return task;
    }).toList();
    return newAsksArray;
  }
}

class Day {
  final String name;
  final int completed;

  Day({required this.name, required this.completed});

  @override
  String toString() => "$name: $completed";
}

class HomeVariable {
  final double percentage;
  final int completed;
  final int totalTasks;

  HomeVariable({required this.percentage, required this.completed, required this.totalTasks });

}