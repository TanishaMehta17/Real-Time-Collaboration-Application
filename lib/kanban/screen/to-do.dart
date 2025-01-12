import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/utils/customCard.dart';
import 'package:real_time_collaboration_application/utils/custom_card_category.dart';
import 'package:real_time_collaboration_application/utils/drawer.dart';


class ToDoScreen extends StatelessWidget {
  static const String routeName = '/to-do-screen';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final toDoTasks = taskProvider.getTasksByCategory('to-do');
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('To-Do Tasks', style: RTSTypography.buttonText),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.task,
              color: white,
            )
          ],
        ),
        backgroundColor: textColor2,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu, color: white),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: toDoTasks.isNotEmpty
          ? ListView.builder(
              itemCount: toDoTasks.length,
              itemBuilder: (context, index) => CustomCardCategory(task: toDoTasks[index]),
            )
          : const Center(
              child: Text(
                'No To-Do Tasks',
                style: RTSTypography.buttonText,
              ),
            ),
    );
  }
}