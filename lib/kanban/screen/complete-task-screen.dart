
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/model/task.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/utils/customCard.dart';
import 'package:real_time_collaboration_application/utils/custom_card_category.dart';
import 'package:real_time_collaboration_application/utils/drawer.dart';


class CompleteTask extends StatelessWidget {
  static const String routeName = '/complete-task-screen';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    var completeTask = taskProvider.getTasksByCategory('complete');
    
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Completed Tasks', style: RTSTypography.buttonText),
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
       body: completeTask.isNotEmpty
          ? ListView.builder(
              itemCount: completeTask.length,
              itemBuilder: (context, index) => CustomCardCategory(task: completeTask[index]),
            )
          : const Center(
              child: Text(
                'No Complete Tasks',
                style: RTSTypography.buttonText,
              ),
            ),
    );
  }
}