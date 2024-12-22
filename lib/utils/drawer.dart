import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/kanban/screen/all-list.dart';
import 'package:real_time_collaboration_application/kanban/screen/baclog.dart';
import 'package:real_time_collaboration_application/kanban/screen/review.dart';
import 'package:real_time_collaboration_application/kanban/screen/to-do.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy tasks list - Replace with actual dynamic data if required.
    final tasks = [
      {'id': 1, 'title': 'Task 1', 'status': 'In Review'},
      {'id': 2, 'title': 'Task 2', 'status': 'Backlog'},
    ];

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue, // Adjust color based on your theme.
            padding: const EdgeInsets.only(top: 30.0, bottom: 20),
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white, // Adjust color for contrast.
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.arrow_forward_ios),
            title: const Text('Backlog'),
            onTap: () {
              Navigator.pushNamed(context, Backlog.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_forward_ios),
            title: const Text('To-Do'),
            onTap: () {
              Navigator.pushNamed(context, ToDoScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_forward_ios),
            title: const Text('In Review'),
            onTap: () {
              Navigator.pushNamed(
                context,
                Review.routeName,
                arguments: tasks,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_forward_ios),
            title: const Text('All'),
            onTap: () {
              Navigator.pushNamed(context, AllTask.routeName);
            },
          ),
        ],
      ),
    );
  }
}
