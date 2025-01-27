import 'package:flutter/material.dart';
import '../widgets/task_list.dart';
import 'add_task_screen.dart';
import '../database_helper.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Replace the _tasks list with data from SQLite
  List<Map<String, dynamic>>_tasks=[];


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taskly')),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(

        //tambah
      onPressed: () async {
        await DatabaseHelper.instance.deleteTask(task['id']);
        _loadTasks();
        },
        onTap: () async {
          await DatabaseHelper.instance.updateTask(
            task['id'],
            task['completed'] == 0 ? 1 : 0,
            );
            _loadTasks();
            },
        child: Icon(Icons.add),
        onPressed: () {

          // Update the FloatingActionButton to save tasks to the database
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
        },
      ),
    );
  }
}

