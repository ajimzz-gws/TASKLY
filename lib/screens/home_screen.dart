import 'package:flutter/material.dart';
import '../widgets/task_list.dart';
import 'add_task_screen.dart';
import '../database_helper.dart';
import 'collection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when the widget is initialized
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseHelper.instance.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (newTask.isNotEmpty) {
                  await DatabaseHelper.instance.addTask(newTask);
                  _loadTasks(); // Reload tasks after adding
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task['title']),
            trailing: IconButton(
              icon: Icon(
                task['completed'] == 1 ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              onPressed: () async {
                await DatabaseHelper.instance.updateTask(
                  task['id'],
                  task['completed'] == 0 ? 1 : 0,
                );
                _loadTasks();
              },
            ),
            onLongPress: () async {
              await DatabaseHelper.instance.deleteTask(task['id']);
              _loadTasks();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to CollectionsScreen OR add task functionality
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add Task'),
                    onTap: () {
                      Navigator.pop(context);
                      _addTask();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.collections),
                    title: Text('View Collections'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CollectionsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
