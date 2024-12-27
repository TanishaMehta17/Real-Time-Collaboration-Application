import 'dart:convert';

class Team {
  final String id;
  final String name;
  final String password;
  final String managerId;
  final List<String> members;

  Team({
    required this.id,
    required this.name,
    required this.password,
    required this.managerId,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'managerId': managerId,
      'members': members,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      managerId: map['managerId'] ?? '',
      members: List<String>.from(map['members'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source));

  Team copyWith({
    String? id,
    String? name,
    String? password,
    String? managerId,
    List<String>? members,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      managerId: managerId ?? this.managerId,
      members: members ?? this.members,
    );
  }
}
