import 'dart:convert';

class Task {
  final String heading1;
  final String heading2;
  final String bodyText1;
  final String bodyText2;
  final String name;
  final String date;
  final String category;
  final List<String> membersName;
  Task(
      {required this.heading1,
      required this.heading2,
      required this.bodyText1,
      required this.bodyText2,
      required this.name,
      required this.date,
      required this.category,
      required this.membersName
      });
     Map<String, dynamic> toMap() {
      return {
        'heading1':heading1,
        'heading2':heading2,
        'bodyText1':bodyText1,
        'bodyText2':bodyText2,
        'name':name,
        'date':date,
        'category':category,
        'membersName':membersName
      };
    }

    factory Task.fromMap(Map<String, dynamic> map) {
      return Task(
        heading1: map['heading1'] ?? '',
        heading2: map['heading2'] ?? '',
        bodyText1: map['bodyText1'] ?? '',
        bodyText2: map['bedyText2'] ?? '',
        category: map['category']??'',
        membersName: map['membersName']??'',
        name: map['name'] ?? '',
        date: map['date'] ?? '',
      );
    }

    String toJson() => json.encode(toMap());

    factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

    Task copyWith({
      String? heading1,
      String? heading2,
      String? bodyText1,
      String? bodyText2,
      String? category,
      String? name,
      String? date,
      List<String>? membersName
    }) {
      return Task(
        heading1:heading1 ?? this.heading1,
        heading2:heading2 ?? this.heading2,
        bodyText1:bodyText1?? this.bodyText1,
        bodyText2:bodyText2??this.bodyText2,
        category: category??this.category,
        name:name??this.name,
        date:date??this.date,
        membersName: membersName??this.membersName,
      );
    } 
}
