import 'package:flutter/material.dart';
import 'create_task_screen.dart';
import 'task_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('image.png', width: 120, height: 120),
                SizedBox(height: 20),
                Text(
                  'Schedule your tasks',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Manage your task schedule easily and efficiently',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              'Hi Jerome',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: FilterOptions(),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateTaskScreen(),
                ));
              },
              child: Icon(Icons.add, color: Color.fromARGB(255, 13, 5, 128)),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Option 1',
            child: Row(
              children: [
                Icon(Icons.date_range),
                SizedBox(width: 8),
                Text('Sort by date'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'Option 2',
            child: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(width: 8),
                Text('Completed tasks'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'Option 3',
            child: Row(
              children: [
                Icon(Icons.pending_actions),
                SizedBox(width: 8),
                Text('Pending tasks'),
              ],
            ),
          ),
        ];
      },
      icon: Icon(Icons.filter_list),
      onSelected: (String value) {
        // Handle selected option
      },
    );
  }
}
