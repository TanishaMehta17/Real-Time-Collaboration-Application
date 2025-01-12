import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/global_variable.dart';
import 'package:real_time_collaboration_application/kanban/services/taskservices.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/teamProvider.dart';
import 'package:real_time_collaboration_application/providers/userProvider.dart';
import 'package:real_time_collaboration_application/utils/customCard.dart';
import 'package:real_time_collaboration_application/utils/drawer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AllTask extends StatefulWidget {
  String teamId;
  AllTask({Key? key, required this.teamId}) : super(key: key);
  static const String routeName = '/all-task-screen';

  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  final TextEditingController heading1 = TextEditingController();
  final TextEditingController heading2 = TextEditingController();
  final TextEditingController bodyText1 = TextEditingController();
  final TextEditingController bodyText2 = TextEditingController();
  final ScrollController scrollController = ScrollController();
  TaskService taskService = TaskService();
  String selectedDate = "Selcet Date";
  late IO.Socket socket;

  List<String> selectedMembers = [];
  final _formKey = GlobalKey<FormState>();
  String selectedCategory = 'To-Do';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set initial date to today
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Convert picked DateTime to String and update selectedDate
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
        print(
            "Selected Date: $selectedDate"); // Debugging line to check the date string
      });
    }
  }

  List<String> membersName = [];
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskService.getmembers(
      context: context,
      teamname: teamProvider.team.name,
      callback: (success, tasks) {
        if (success) {
          print("Members fetched");
          setState(() {
            membersName = List<String>.from(tasks);
          });
        } else {
          print("Members not fetched");
        }
      },
    );
    print("alll taskkkk");
    print(taskProvider.allTasks);
    setupSocketConnection();
  }

  @override
  void dispose() {
    heading1.dispose();
    heading2.dispose();
    bodyText1.dispose();
    bodyText2.dispose();
    scrollController.dispose();
    socket.dispose();
    super.dispose();
  }
 @override
void didChangeDependencies() {
  super.didChangeDependencies();
  // Emit to fetch tasks if not already loaded
  if (tasks.isEmpty) {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    socket.emit("getTask", teamProvider.team.id);
     socket.on("tasks", (data) {
        setState(() {
          tasks = List<Map<String, dynamic>>.from(data);
          taskProvider.setTasks(tasks);
        });
        scrollToBottom();
      });
  }
}
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void setupSocketConnection() {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    socket = IO.io(
      uri, // Replace with your backend URL
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("Connected to server");

      print(teamProvider.team.id);

      //Join the task room
      socket.emit("joinTeam", teamProvider.team.id);

      // Fetch existing tasks
      socket.emit("getTask", teamProvider.team.id);

      // Listen for existing tasks
      socket.on("tasks", (data) {
        setState(() {
          tasks = List<Map<String, dynamic>>.from(data);
          taskProvider.setTasks(tasks);
        });
        scrollToBottom();
      });
      
      // Listen for new messages
      socket.on("taskCreated", (data) {
        setState(() {
          tasks.add(data);
        });
        scrollToBottom();
      });
    });
    
      
    socket.onDisconnect((_) => print("Disconnected from server"));
  }

  void addTasks() {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);

    final data = {
      "title": heading1.text,
      "description": bodyText1.text,
      "description1": bodyText2.text,
      "membersName": selectedMembers,
      "teamId": teamProvider.team.id,
      "type": heading2.text,
      "status": selectedCategory,
      "date": selectedDate,
    };

    // Emit task to the server
    socket.emit("createTask", data);

    // Add to categorizedTasks locally for immediate UI updates
    setState(() {
      heading1.clear();
      heading2.clear();
      bodyText1.clear();
      bodyText2.clear();
      selectedMembers.clear();
      selectedCategory = 'To-Do';
      selectedDate = "Selcet Date";
    });
  }

  void _resetForm() {
    heading1.clear();
    heading2.clear();
    bodyText1.clear();
    bodyText2.clear();
    setState(() {
      selectedDate = "";
      selectedMembers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final userProvider = Provider.of<UserProvider>(context);
    final teamProvider = Provider.of<TeamProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All Tasks',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Icon(Icons.task, color: Colors.white),
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
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : ListView.builder(
              controller: scrollController,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return CustomCard(task: task, socket: socket, tasks: tasks,);
              },
            ),
      floatingActionButton: userProvider.user.id == teamProvider.team.managerId
          ? FloatingActionButton(
              backgroundColor: textColor2,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Add New Task',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    content: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(heading1, 'Heading 1'),
                            const SizedBox(height: 16),
                            _buildTextField(heading2, 'Heading 2'),
                            const SizedBox(height: 16),
                            _buildTextField(bodyText1, 'Body Text 1'),
                            const SizedBox(height: 16),
                            _buildTextField(bodyText2, 'Body Text 2'),
                            const SizedBox(height: 16),
                            _buildDropdown(),
                            const SizedBox(height: 16),
                            _buildDatePicker(),
                            const SizedBox(height: 16),
                            _buildCategoryDropdown(),
                            const SizedBox(height: 24),
                            _buildSubmitButton(),
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
            )
          : null,
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$label cannot be empty',
                style: RTSTypography.smallText2.copyWith(color: white),
              ),
              backgroundColor: errorPrimaryColor,
            ),
          );
          return ''; // Return empty string to show the error
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: textColor2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.edit, color: textColor2),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      hint: const Text("Select Members"),
      value:
          null, // Leave value as null to manage the selection with checkboxes
      onChanged:
          (value) {}, // We don't need to update the value here as we manage selection with checkboxes
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
                          color: Colors.black), // Display member name
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
                checkColor: Colors
                    .white, // Set the color of the tick mark (checked state)
                activeColor:
                    textColor2, // Set the background color of the checkbox when selected
                side: const BorderSide(
                    color: Colors.grey,
                    width: 1.5), // Border color and width for checkbox
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate, // Show selected date as string
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Select Category',
        labelStyle: const TextStyle(color: textColor2),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: ['To-Do', 'Backlog', 'Review']
          .map((category) => DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              ))
          .toList(),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            addTasks();
            _resetForm();
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please fill all required fields',
                  style: RTSTypography.smallText2.copyWith(color: white),
                ),
                backgroundColor: errorPrimaryColor,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: textColor2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        ),
        child: const Text(
          'Create Task',
          style: RTSTypography.buttonText,
        ),
      ),
    );
  }
}
