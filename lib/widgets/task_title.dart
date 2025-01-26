import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Sample Task'),
      trailing: Checkbox(
        value: false, // Replace with task completion state
        onChanged: (bool? value) {
          // Handle checkbox toggle
        },
      ),
    );
  }
}
