import 'dart:convert';

class Task {
  final String id;
  final String heading1;
  final String heading2;
  final String bodyText1;
  final String bodyText2;
  final String teamId;
  final String date;
  final String category;
  final List<String> membersName;

  Task({
    required this.id,
    required this.heading1,
    required this.heading2,
    required this.bodyText1,
    required this.bodyText2,
    required this.teamId,
    required this.date,
    required this.category,
    required this.membersName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'heading1': heading1,
      'heading2': heading2,
      'bodyText1': bodyText1,
      'bodyText2': bodyText2,
      'teamId': teamId,
      'date': date,
      'category': category,
      'membersName': membersName,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      heading1: map['title'] ?? '', // Map 'title' to 'heading1'
      heading2: map['type'] ?? '', // Map 'type' to 'heading2'
      bodyText1: map['description'] ?? '', // Map 'description' to 'bodyText1'
      bodyText2: map['description1'] ?? '', // Map 'description1' to 'bodyText2'
      category: map['status'] ?? '', // Map 'status' to 'category'
      membersName: List<String>.from(map['membersName'] ?? []), // Map 'membersName'
      teamId: map['teamId'] ?? '', // No teamId mapping in API, set default
      date: map['date'] ?? '', // No date mapping in API, set default
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  Task copyWith({
    String? id,
    String? heading1,
    String? heading2,
    String? bodyText1,
    String? bodyText2,
    String? teamId,
    String? date,
    String? category,
    List<String>? membersName,
  }) {
    return Task(
      id: id ?? this.id,
      heading1: heading1 ?? this.heading1,
      heading2: heading2 ?? this.heading2,
      bodyText1: bodyText1 ?? this.bodyText1,
      bodyText2: bodyText2 ?? this.bodyText2,
      teamId: teamId ?? this.teamId,
      date: date ?? this.date,
      category: category ?? this.category,
      membersName: membersName ?? this.membersName,
    );
  }
}
