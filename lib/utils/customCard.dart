import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/chat/screen/chat_screen.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/teamProvider.dart';
import 'package:real_time_collaboration_application/providers/userProvider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CustomCard extends StatefulWidget {
  final Map<String, dynamic> task; // Define the task parameter
  final IO.Socket socket;
   List<Map<String, dynamic>> tasks = [];

  CustomCard({required this.task, required this.socket, required this.tasks});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.task['status'];
  }

  // Emit task status update to backend
  void _updateTaskStatus(String taskId, String newStatus) {
    final taskProvider= Provider.of<TaskProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    widget.socket.emit('updateStatus', {
      'taskId': taskId,
      'newStatus': newStatus,
    });
    setState(() {
    widget.task['status'] = newStatus;
    widget. socket.emit("getTask", teamProvider.team.id);

      // Listen for existing tasks
      widget.socket.on("tasks", (data) {
        setState(() {
          widget.tasks = List<Map<String, dynamic>>.from(data);
          taskProvider.setTasks(widget.tasks);
        });
      });
  });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: boxShadow.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Chip(
                label: Text(widget.task['title'],
                    style: RTSTypography.buttonText
                        .copyWith(color: headingColor1)),
                backgroundColor: boxColor1,
              ),
              const SizedBox(width: 25),
              Chip(
                label: Text(widget.task['type'],
                    style: RTSTypography.buttonText
                        .copyWith(color: headingColor2)),
                backgroundColor: boxColor2,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              widget.task['description'],
              style: RTSTypography.buttonText
                  .copyWith(fontWeight: FontWeight.w500, color: textColor),
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              widget.task['description1'],
              style: RTSTypography.buttonText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor.withOpacity(0.60)),
            ),
          ),
          const SizedBox(height: 16.0),
          const Divider(height: 20.0, color: boxShadow),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        widget.task['membersName']
                                .contains(userProvider.user.username)
                            ? Navigator.pushNamed(context, ChatScreen.routeName,
                                arguments: {
                                    "taskId": widget.task['id'],
                                  })
                            : Future.delayed(Duration.zero, () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('You need access to this task'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });
                      },
                      icon: const Icon(Icons.chat)),
                  const SizedBox(width: 8.0),
                  Text(widget.task['status'],
                      style:
                          RTSTypography.buttonText.copyWith(color: textColor)),
                  const SizedBox(width: 16.0),
                  if (userProvider.user.id == teamProvider.team.managerId)
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 16,
                      elevation: 16,
                      style: TextStyle(color: headingColor1),
                      underline: Container(
                        height: 2,
                        color: headingColor1,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                          _updateTaskStatus(widget.task['id'], dropdownValue);
                        }
                      },
                      items: <String>['To-Do', 'Review', 'Backlog', 'Complete']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Radio<String>(
                                value: value,
                                groupValue: dropdownValue,
                                onChanged: (String? selectedValue) {
                                  if (selectedValue != null) {
                                    setState(() {
                                      dropdownValue = selectedValue;
                                    });
                                    _updateTaskStatus(
                                        widget.task['id'], dropdownValue);
                                  }
                                },
                              ),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16.0, color: boxShadow),
                  const SizedBox(width: 4.0),
                  Text(widget.task['date'], style: RTSTypography.smallText2),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
