import 'package:flutter/material.dart';
import '../widgets/task_list.dart';
import 'add_task_screen.dart';

class HomeScreenOld extends StatelessWidget {
  const HomeScreenOld({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taskly')),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
      ),
    );
  }
}

//Add a ListView to display tasks in the Scaffold body. For now, use a hardcoded list to represent the tasks.

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Buy groceries', 'completed': false},
    {'title': 'Do laundry', 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taskly'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(
              task['title'],
              style: TextStyle(
                decoration: task['completed']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                });
              },
            ),
            onTap: () {
              setState(() {
                task['completed'] = !task['completed'];
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
      
          // Logic to add tasks (handled in Step 2).
          //Add a FloatingActionButton to Add Tasks
          //Add a dialog box to input new tasks. Update the onPressed method of the FloatingActionButton:
         
        onPressed: () {
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
            onPressed: () {
              setState(() {
                if (newTask.isNotEmpty) {
                  _tasks.add({'title': newTask, 'completed': false});
                }
              });
              Navigator.of(context).pop();
            },
            child: Text('Add'),
            ),
           ],
            );
           },
          );
         },
        child: Icon(Icons.add),
      ),
    );
  }
}
