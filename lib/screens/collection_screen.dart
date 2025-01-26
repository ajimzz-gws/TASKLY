import 'package:flutter/material.dart';
import '../services/database_helpers.dart';

class CollectionsScreen extends StatefulWidget {
  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  List<Map<String, dynamic>> _collections = [];

  Future<void> _loadCollections() async {
    final collections = await DatabaseHelper.instance.getCollections();
    setState(() {
      _collections = collections;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  void _addCollection() {
    String name = '';
    String color = '#FF0000'; // Default color
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Collection'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(hintText: 'Collection name'),
              ),
              TextField(
                onChanged: (value) => color = value,
                decoration: InputDecoration(hintText: 'Color (Hex Code)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (name.isNotEmpty) {
                  await DatabaseHelper.instance.addCollection(name, color);
                  _loadCollections();
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
        title: Text('Collections'),
      ),
      body: ListView.builder(
        itemCount: _collections.length,
        itemBuilder: (context, index) {
          final collection = _collections[index];
          return ListTile(
            title: Text(collection['name']),
            leading: CircleAvatar(
              backgroundColor: Color(
                  int.parse(collection['color'].substring(1, 7), radix: 16) +
                      0xFF000000),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await DatabaseHelper.instance
                    .deleteCollection(collection['id']);
                _loadCollections();
              },
            ),
            onTap: () {
              Navigator.of(context).pop(collection);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCollection,
        child: Icon(Icons.add),
      ),
    );
  }
}
