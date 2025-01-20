import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Sample Task'),
      trailing: Checkbox(
        value: false, // Replace with task completion state
        onChanged: (bool? value) {
          // Handle checkbox toggle
        },
      ),
    );
  }
}
