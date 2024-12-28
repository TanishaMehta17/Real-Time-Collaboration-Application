import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/utils/customCard.dart';
import 'package:real_time_collaboration_application/utils/drawer.dart';


class Review extends StatelessWidget {
  static const String routeName = '/review-screen';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final reviewTasks = taskProvider.getTasksByCategory('review');
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Review Tasks', style: RTSTypography.buttonText),
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
      body: reviewTasks.isNotEmpty
          ? ListView.builder(
              itemCount: reviewTasks.length,
              itemBuilder: (context, index) => CustomCard(task: reviewTasks[index]),
            )
          : const Center(
              child: Text(
                'No Review Tasks',
                style: RTSTypography.buttonText,
              ),
            ),
    );
  }
}