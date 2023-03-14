class UserModel {
  final String? id;
  final String title;
  final DateTime date;
  final DateTime start_time;
  final String category;
  final int working_sessions;
  final int short_break;
  final int long_break;

  UserModel(
      {
        required this.id,
        required this.title,
        required this.date,
        required this.start_time,
        required this.category,
        required this.working_sessions,
        required this.short_break,
        required this.long_break,
      });
}
