import 'dart:convert';

class Team {
  final String id;
  final String name;
  final String password;
  final String managerId;

  Team({
    required this.id,
    required this.name,
    required this.password,
    required this.managerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'managerId': managerId,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      managerId: map['managerId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source));

  Team copyWith({
    String? id,
    String? name,
    String? password,
    String? managerId,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      managerId: managerId ?? this.managerId,
    );
  }
}
