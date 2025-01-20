import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Ensure this file exists

void main() {
  runApp(TasklyApp());
}

class TasklyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(), // Ensure Homescreen is properly imported
    );
  }
}
