class AppNotification {
  final int id;
  final String message;
  final DateTime date;

  AppNotification({
    required this.id,
    required this.message,
    required this.date,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] ?? 0,
      message: json['message'] ?? 'No message',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }

  static AppNotification defaultNotification() {
    return AppNotification(
      id: 0,
      message: 'Default message',
      date: DateTime.now(),
    );
  }
}