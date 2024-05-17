import 'dart:convert';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date, required DateTime endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
       endDate: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
