import 'package:flutter/material.dart';
import 'task_title.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with actual task count
      itemBuilder: (context, index) {
        return TaskTile();
      },
    );
  }
}
