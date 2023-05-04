import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String? id;
  final String title;
  final String description;
  final date;
  final start_time;
  final String category;
  final int working_session_duration;
  final int working_sessions;
  final int short_break;
  final int long_break;
  final int long_break_starts;
  final bool completed;
  int completed_sessions;
  var color;
  var icon;
  var status;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.start_time,
      required this.category,
      required this.working_session_duration,
      required this.working_sessions,
      required this.short_break,
      required this.long_break,
      required this.long_break_starts,
      required this.completed,
      required this.completed_sessions,
      this.status,
      this.color,
      this.icon});

  toJson() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "start_time": start_time,
      "category": category,
      "working_session_duration": working_session_duration,
      "working_sessions": working_sessions,
      "short_break": short_break,
      "long_break": long_break,
      "long_break_start": long_break_starts,
      "completed": completed,
      "completed_sessions": completed_sessions
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
        working_session_duration: data["working_session_duration"],
        working_sessions: data["working_sessions"],
        short_break: data["short_break"],
        long_break: data["long_break"],
        long_break_starts: data["long_break_starts"],
        completed_sessions: data["completed_sessions"],
        completed: data["completed"]);
  }
}
