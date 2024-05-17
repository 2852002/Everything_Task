import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../screens/update_task_screen.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return Container(
          color: Colors.white,
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: task.id,
                  groupValue: null,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (String value) async {
                            if (value == 'edit') {
                              final updatedTask = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdateTaskScreen(task: task),
                                ),
                              );
                              if (updatedTask != null) {
                                taskProvider.updateTask(task.id, updatedTask);
                              }
                            } else if (value == 'delete') {
                              taskProvider.deleteTask(task.id);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return {'edit', 'delete'}.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Row(
                                  children: [
                                    Icon(
                                      choice == 'edit' ? Icons.edit : Icons.delete,
                                      color: choice == 'delete' ? Colors.red : null,
                                    ),
                                    SizedBox(width: 8),
                                    Text(choice == 'edit' ? 'Edit' : 'Delete'),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          task.description,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text(
                            DateFormat.yMMMd().format(task.date),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
