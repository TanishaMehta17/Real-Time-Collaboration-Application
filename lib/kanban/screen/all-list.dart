import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/model/task.dart';
import 'package:real_time_collaboration_application/provider/taskProvider.dart';
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
  final TextEditingController name = TextEditingController();
  DateTime? selectedDate;
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

  @override
  void dispose() {
    heading1.dispose();
    heading2.dispose();
    bodyText1.dispose();
    bodyText2.dispose();
    name.dispose();
    super.dispose();
  }

  void _resetForm() {
    heading1.clear();
    heading2.clear();
    bodyText1.clear();
    bodyText2.clear();
    name.clear();
    setState(() {
      selectedDate = null;
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
                child: Column(
                  children: [
                    TextFormField(
                      controller: heading1,
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
                      decoration: InputDecoration(
                        labelText: 'Body Text 2',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                        // Check if all fields are empty
                        if (heading1.text.isEmpty &&
                            heading2.text.isEmpty &&
                            bodyText1.text.isEmpty &&
                            bodyText2.text.isEmpty &&
                            name.text.isEmpty) {
                          // If all fields are empty, show a Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(
                                'Please enter details',
                                style: RTSTypography.smallText2.copyWith(color: white),
                              ),
                              backgroundColor: errorPrimaryColor,
                            ),
                          );
                        } else {
                          // Proceed to create a new task if at least one field is filled
                          final newTask = Task(
                            heading1: heading1.text,
                            heading2: heading2.text,
                            bodyText1: bodyText1.text,
                            bodyText2: bodyText2.text,
                            name: name.text,
                            date: selectedDate?.toString().split(' ')[0] ?? '',
                            category: selectedCategory,
                          );
                          taskProvider.addTask(newTask); // Add the new task
                          _resetForm(); // Reset the form fields
                          Navigator.pop(context); // Close the dialog
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
