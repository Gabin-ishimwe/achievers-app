import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String? id;
  final String title;
  final String description;
  final date;
  final start_time;
  final String category;
  final int working_sessions;
  final int short_break;
  final int long_break;
  var color;
  var icon;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.start_time,
      required this.category,
      required this.working_sessions,
      required this.short_break,
      required this.long_break,
      this.color,
      this.icon});

  toJson() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "start_time": start_time,
      "category": category,
      "working_sessions": working_sessions,
      "short_break": short_break,
      "long_break": long_break
    };
  }

  factory Task.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Task(
        id: document.id,
        title: data["title"],
        description: data["description"],
        date: data["date"],
        start_time: data["start_time"],
        category: data["category"],
        working_sessions: data["working_sessions"],
        short_break: data["short_break"],
        long_break: data["long_break"]);
  }
}
