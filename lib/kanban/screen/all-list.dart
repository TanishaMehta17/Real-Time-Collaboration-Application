import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/kanban/services/taskservices.dart';
import 'package:real_time_collaboration_application/model/task.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/teamProvider.dart';

import 'package:real_time_collaboration_application/utils/customCard.dart';
import 'package:real_time_collaboration_application/utils/drawer.dart';

class AllTask extends StatefulWidget {
  static const String routeName = '/all-task-screen';

  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  final TextEditingController heading1 = TextEditingController();
  final TextEditingController heading2 = TextEditingController();
  final TextEditingController bodyText1 = TextEditingController();
  final TextEditingController bodyText2 = TextEditingController();
  TaskService taskService = TaskService();
  DateTime? selectedDate = DateTime.now();
  List<String> selectedMembers = [];
  final _formKey = GlobalKey<FormState>();
  String selectedCategory = 'To-Do';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  List<String> membersName = [];

  @override
  void initState() {
    super.initState();
    membersName =
        Provider.of<TeamProvider>(context, listen: false).team.members;
  }

  @override
  void dispose() {
    heading1.dispose();
    heading2.dispose();
    bodyText1.dispose();
    bodyText2.dispose();
    super.dispose();
  }

  void _resetForm() {
    heading1.clear();
    heading2.clear();
    bodyText1.clear();
    bodyText2.clear();

    setState(() {
      selectedDate = null;
      selectedMembers.clear();
    });
  }

  void addTasks() {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    taskService.CreateTask(
        context: context,
        TaskType: "${heading1.text} and ${heading2.text}",
        TaskName: bodyText1.text,
        TaskDescription: bodyText2.text,
        TaskStatus: selectedCategory,
        membersName: [],
        teamId: teamProvider.team.id,
        callback: (bool success) {
          if (success) {
            print("Task Created");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Task not created',
                  style: RTSTypography.smallText2.copyWith(color: white),
                ),
                backgroundColor: errorPrimaryColor,
              ),
            );

            print("Task not Created");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    // Always display tasks from allTasks list for the "All Tasks" screen
    List<Task> filteredTasks = taskProvider.allTasks; // Get all tasks here

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('All Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Icon(Icons.task, color: Colors.white)
          ],
        ),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: taskProvider.allTasks.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  ...filteredTasks
                      .map((task) => CustomCard(task: task))
                      .toList(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: textColor2,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add New Task'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: heading1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Heading1 cannot be empty',
                                  style: RTSTypography.smallText2
                                      .copyWith(color: white),
                                ),
                                backgroundColor: errorPrimaryColor,
                              ),
                            );
                            return ''; // Return empty string to show the error
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Heading 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: heading2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Heading2 cannot be empty',
                                  style: RTSTypography.smallText2
                                      .copyWith(color: white),
                                ),
                                backgroundColor: errorPrimaryColor,
                              ),
                            );
                            return ''; // Return empty string to show the error
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Heading 2',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: bodyText1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'BodyText1 cannot be empty',
                                  style: RTSTypography.smallText2
                                      .copyWith(color: white),
                                ),
                                backgroundColor: errorPrimaryColor,
                              ),
                            );
                            return ''; // Return empty string to show the error
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Body Text 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: bodyText2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'BodyText2 cannot be empty',
                                  style: RTSTypography.smallText2
                                      .copyWith(color: white),
                                ),
                                backgroundColor: errorPrimaryColor,
                              ),
                            );
                            return ''; // Return empty string to show the error
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Body Text 2',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text("Select Members"),
                        value:
                            null, // Leave value as null because we manage selection with checkboxes
                        onChanged: (value) {},
                        items: membersName.map((String member) {
                          return DropdownMenuItem<String>(
                            value: member,
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return CheckboxListTile(
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 8.0),
                                      Text(
                                        member,
                                        style: const TextStyle(
                                            color: Colors
                                                .black), // Display member name
                                      ),
                                    ],
                                  ),
                                  value: selectedMembers.contains(
                                      member), // Checked state based on whether the member is selected
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        // Add member to the selectedMembers list if checked
                                        selectedMembers.add(member);
                                      } else {
                                        // Remove member from the selectedMembers list if unchecked
                                        selectedMembers.remove(member);
                                      }
                                    });
                                  },
                                  checkColor:
                                      white, // Set the color of the tick mark (checked state)
                                  activeColor: textColor2,
                                  // Set the background color of the checkbox when selected (blue)
                                  side: const BorderSide(
                                      color: Colors.grey,
                                      width:
                                          1.5), // Border color and width for checkbox
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null
                                    ? 'Select Date'
                                    : selectedDate.toString().split(' ')[0],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today,
                                  color: Colors.blueAccent),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButtonFormField<String>(
                          value: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Select Category',
                            labelStyle: const TextStyle(
                              color: textColor2, // Customize the label color
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: textColor2, // Customize border color
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: textColor2, // Focused border color
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                          ),
                          items: ['To-Do', 'Backlog', 'Review']
                              .map((category) => DropdownMenuItem<String>(
                                    value: category,
                                    child: Row(
                                      children: [
                                        Icon(
                                          category == selectedCategory
                                              ? Icons.check_circle
                                              : Icons.radio_button_unchecked,
                                          color: category == selectedCategory
                                              ? textColor2
                                              : boxShadow,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          category,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: category == selectedCategory
                                                ? textColor2
                                                : textColor,
                                            fontWeight:
                                                category == selectedCategory
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // If validation passes, proceed with adding the task
                            addTasks();
                            print(selectedMembers);
                            _resetForm();
                            Navigator.pop(context);
                          } else {
                            // If validation fails, show the Snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please fill all required fields',
                                  style: RTSTypography.smallText2
                                      .copyWith(color: white),
                                ),
                                backgroundColor: errorPrimaryColor,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: RTSTypography.buttonText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }
}
