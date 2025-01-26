import 'package:flutter/material.dart';
import 'collection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tasks = [];

  void _loadTasks() {
    setState(() {
      tasks = ['Task 1', 'Task 2', 'Task 3']; // Example task loading logic
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Ensure _loadTasks is defined and called in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CollectionsScreen(), // Ensure CollectionScreen is properly imported and used
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
