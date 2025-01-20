import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Task'),
              onPressed: () {
                // Add logic to save task
              },
            ),
          ],
        ),
      ),
    );
  }
}
