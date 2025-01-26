import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Add Task'),
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
