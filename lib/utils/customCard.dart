import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/chat/screen/chat_screen.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/teamProvider.dart';
import 'package:real_time_collaboration_application/providers/userProvider.dart';
import 'package:real_time_collaboration_application/utils/CustomTextFieldForm.dart';
import 'package:real_time_collaboration_application/utils/membersDropdown.dart';
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

  void _showEditForm(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: widget.task['title']);
    final TextEditingController descriptionController =
        TextEditingController(text: widget.task['description']);
    final TextEditingController description1Controller =
        TextEditingController(text: widget.task['description1']);
    final TextEditingController typeController =
        TextEditingController(text: widget.task['type']);
    final TextEditingController dateController =
        TextEditingController(text: widget.task['date']);
    List<String> membersName = List<String>.from(widget.task['membersName']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormFieldNew(
                  controller: titleController,
                  labelText: 'Title',
                ),
                const SizedBox(height: 8.0),
                CustomTextFormFieldNew(
                  controller: descriptionController,
                  labelText: 'Description',
                ),
                const SizedBox(height: 8.0),
                CustomTextFormFieldNew(
                  controller: description1Controller,
                  labelText: 'Additional Description',
                ),
                const SizedBox(height: 8.0),
                CustomTextFormFieldNew(
                  controller: typeController,
                  labelText: 'Type',
                ),
                const SizedBox(height: 8.0),
                CustomTextFormFieldNew(
                  controller: dateController,
                  labelText: 'Date',
                ),
                const SizedBox(height: 8.0),
                MembersDropdown(
                  membersName: membersName,
                  selectedMembers: membersName,
                  onSelectionChanged: (List<String> newMembers) {
                    membersName = newMembers;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _updateTask(
                  widget.task['id'],
                  titleController.text,
                  descriptionController.text,
                  description1Controller.text,
                  typeController.text,
                  widget.task['status'],
                  dateController.text,
                  membersName,
                );
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  // Emit task status update to backend
  void _updateTaskStatus(String taskId, String newStatus) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    widget.socket.emit('updateStatus', {
      'taskId': taskId,
      'newStatus': newStatus,
    });
    setState(() {
      widget.task['status'] = newStatus;
      widget.socket.emit("getTask", teamProvider.team.id);

      // Listen for existing tasks
      widget.socket.on("tasks", (data) {
        setState(() {
          widget.tasks = List<Map<String, dynamic>>.from(data);
          taskProvider.setTasks(widget.tasks);
        });
      });
    });
  }

  // void _updateTask(
  //     String taskId,
  //     String title,
  //     String description,
  //     String description1,
  //     String type,
  //     String status,
  //     String date,
  //     List<String> membersName) {
  //   final taskProvider = Provider.of<TaskProvider>(context, listen: false);
  //   final teamProvider = Provider.of<TeamProvider>(context, listen: false);
  //   widget.socket.emit('updateTask', {
  //     'taskId': taskId,
  //     'status': status,
  //     'title': title,
  //     'description': description,
  //     'description1': description1,
  //     'type': type,
  //     'date': date,
  //     'membersName': membersName,
  //   });
  //   setState(() {
  //     widget.socket.emit("getTask", teamProvider.team.id);
  //     // Listen for existing tasks
  //     widget.socket.on("tasks", (data) {
  //       setState(() {
  //         // widget.socket.emit("getTask", teamProvider.team.id);
  //         widget.tasks = List<Map<String, dynamic>>.from(data);
  //         taskProvider.setTasks(widget.tasks);
  //       });
  //     });
  //   });
  // }
  void _updateTask(
    String taskId,
    String title,
    String description,
    String description1,
    String type,
    String status,
    String date,
    List<String> membersName,
  ) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);

    // Emit the updated task to the server
    widget.socket.emit('updateTask', {
      'taskId': taskId,
      'status': status,
      'title': title,
      'description': description,
      'description1': description1,
      'type': type,
      'date': date,
      'membersName': membersName,
    });

    // Update the local state optimistically for instant feedback
    setState(() {
      widget.task['title'] = title;
      widget.task['description'] = description;
      widget.task['description1'] = description1;
      widget.task['type'] = type;
      widget.task['status'] = status;
      widget.task['date'] = date;
      widget.task['membersName'] = membersName;
      widget.socket.emit("getTask", teamProvider.team.id);
    });

    // Fetch updated tasks from the backend
    // widget.socket.emit("getTask", teamProvider.team.id);

    // Listen for task updates from the server
    widget.socket.on("tasks", (data) {
      setState(() {
        widget.tasks = List<Map<String, dynamic>>.from(data);
        taskProvider.setTasks(widget.tasks);
      });
    });
  }

  void initState() {
    super.initState();
    dropdownValue = widget.task['status'];
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 10.0),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(241, 236, 236, 0.05),
                    Color.fromRGBO(255, 255, 255, 0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
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
                      // Add an edit icon button visible only to the manager
                      if (userProvider.user.id == teamProvider.team.managerId)
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: textColor1,
                            size: 30,
                          ),
                          onPressed: () {
                            _showEditForm(context);
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      widget.task['description'],
                      style: RTSTypography.buttonText.copyWith(
                          fontWeight: FontWeight.w500, color: textColor),
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
                                    ? Navigator.pushNamed(
                                        context, ChatScreen.routeName,
                                        arguments: {
                                            "taskId": widget.task['id'],
                                          })
                                    : Future.delayed(Duration.zero, () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'You need access to this task'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      });
                              },
                              icon: const Icon(Icons.chat)),
                          const SizedBox(width: 8.0),
                          Text(widget.task['status'],
                              style: RTSTypography.buttonText
                                  .copyWith(color: textColor)),
                          const SizedBox(width: 16.0),
                          if (userProvider.user.id ==
                              teamProvider.team.managerId)
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
                                  _updateTaskStatus(
                                      widget.task['id'], dropdownValue);
                                }
                              },
                              items: <String>[
                                'To-Do',
                                'Review',
                                'Backlog',
                                'Complete'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                            _updateTaskStatus(widget.task['id'],
                                                dropdownValue);
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
                          const SizedBox(width: 3.0),
                          Text(widget.task['date'],
                              style: RTSTypography.smallText2),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
