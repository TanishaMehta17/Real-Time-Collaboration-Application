import 'dart:convert';

class Task {
  final String id;
  final String title;
  final String description;
  final String description1;
  final String type;
  final String teamId;
  final String date;
  final String status;
  final List<String> membersName;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.description1,
    required this.type,
    required this.teamId,
    required this.date,
    required this.status,
    required this.membersName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'description1': description1,
      'type': type,
      'teamId': teamId,
      'date': date,
      'status': status,
      'membersName': membersName,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      description1: map['description1'] ?? '',
      type: map['type'] ?? '',
      teamId: map['teamId'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? '',
      membersName: List<String>.from(map['membersName'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? description1,
    String? type,
    String? teamId,
    String? date,
    String? status,
    List<String>? membersName,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      description1: description1 ?? this.description1,
      type: type ?? this.type,
      teamId: teamId ?? this.teamId,
      date: date ?? this.date,
      status: status ?? this.status,
      membersName: membersName ?? this.membersName,
    );
  }
}
