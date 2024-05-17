import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import '../models/task.dart';
import 'create_task_screen.dart';
import 'home_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Task> _filteredTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
    _searchController.addListener(_searchTasks);
  }

  void _fetchTasks() {
    List<Task> allTasks = Provider.of<TaskProvider>(context, listen: false).tasks;
    allTasks.sort((a, b) => b.date.compareTo(a.date)); // Sort tasks by date descending
    setState(() {
      _filteredTasks = List<Task>.from(allTasks); // Copy the tasks list
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchTasks() {
    final query = _searchController.text.toLowerCase();
    final allTasks = Provider.of<TaskProvider>(context, listen: false).tasks;
    List<Task> filteredTasks = [];

    if (query.isNotEmpty) {
      filteredTasks = allTasks.where((task) {
        final title = task.title.toLowerCase();
        return title.contains(query);
      }).toList();
    } else {
      filteredTasks = allTasks;
    }

    setState(() {
      _filteredTasks = filteredTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Hi Jerome'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.filter_list),
      //       onPressed: () {              // No need to position FilterOptions here

      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
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
            SizedBox(height: 20),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, right: 20, left: 20,bottom: 20),
            
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search recent task',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
              
            // SizedBox(height: 20),
                
              
            Expanded(
                child: ListView.builder(
                  itemCount: _filteredTasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(task: _filteredTasks[index]);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateTaskScreen(),
          )).then((_) {
            _fetchTasks(); // Update task list after creating task
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
