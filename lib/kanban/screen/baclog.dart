
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/model/task.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/utils/customCard.dart';
import 'package:real_time_collaboration_application/utils/custom_card_category.dart';
import 'package:real_time_collaboration_application/utils/drawer.dart';


class Backlog extends StatelessWidget {
  static const String routeName = '/backlog-screen';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    var backlogTasks = taskProvider.getTasksByCategory('backlog');
    
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Backlog Tasks', style: RTSTypography.buttonText),
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
       body: backlogTasks.isNotEmpty
          ? ListView.builder(
              itemCount: backlogTasks.length,
              itemBuilder: (context, index) => CustomCardCategory(task: backlogTasks[index]),
            )
          : const Center(
              child: Text(
                'No Backlog Tasks',
                style: RTSTypography.buttonText,
              ),
            ),
    );
  }
}