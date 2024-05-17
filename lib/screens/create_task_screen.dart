import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'task_list_screen.dart';
import '../widgets/labeled_text_field.dart'; // Import the new widget

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime? _startRangeDate;
  DateTime? _endRangeDate;

  @override
  void initState() {
    super.initState();
    _titleController.text = '';
    _descriptionController.text = '';
  }

  void _saveTask(BuildContext context) {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }

    final newTask = Task(
      id: DateTime.now().toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate, endDate: _selectedDate,
    );

    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
    Provider.of<TaskProvider>(context, listen: false).notifyListeners();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => TaskListScreen(),
    ));
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) {
        return isInRange(day) || isStartRange(day) || isEndRange(day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          if (_startRangeDate == null || _endRangeDate != null) {
            _startRangeDate = selectedDay;
            _endRangeDate = null;
          } else {
            if (selectedDay.isAfter(_startRangeDate!)) {
              _endRangeDate = selectedDay;
            } else {
              _endRangeDate = _startRangeDate;
              _startRangeDate = selectedDay;
            }
          }
          _selectedDate = selectedDay;
        });
      },
    );
  }

  bool isInRange(DateTime day) {
    if (_startRangeDate == null || _endRangeDate == null) return false;
    return day.isAfter(_startRangeDate!) && day.isBefore(_endRangeDate!);
  }

  bool isStartRange(DateTime day) {
    if (_startRangeDate == null) return false;
    return _startRangeDate!.isAtSameMomentAs(day);
  }

  bool isEndRange(DateTime day) {
    if (_endRangeDate == null) return false;
    return _endRangeDate!.isAtSameMomentAs(day);
  }

  String getFormattedRange() {
    if (_startRangeDate == null) return 'Select a date range';
    if (_endRangeDate == null) return 'Task starting at ${_startRangeDate!.toIso8601String().substring(0, 10)}';
    return 'Task starting at ${_startRangeDate!.toIso8601String().substring(0, 10)} - ${_endRangeDate!.toIso8601String().substring(0, 10)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _buildCalendar(),
                SizedBox(height: 20),
                LabeledTextField(
                  hintText: 'Select a date range',
                  controller: TextEditingController(text: getFormattedRange()),
                  readOnly: true,
                ),
                SizedBox(height: 20),
                LabeledTextField(
                hintText: 'Task title',
                  label: 'Title',
                  controller: _titleController,
                ),
                SizedBox(height: 20),
                LabeledTextField(
                hintText: 'Task Description',

                  label: 'Description',
                maxLines: 5,

                  controller: _descriptionController,
                ),
                SizedBox(height: 20),
               Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2), // Adjust the value to your preference
        // color: Colors.grey, // Adjust the color to your preference
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.grey, // Text color
        ),
        child: Text('Cancel', style: TextStyle(color: Colors.black),),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2), // Adjust the value to your preference
        // color: Colors.blue, // Adjust the color to your preference
      ),
      child: ElevatedButton(
        onPressed: () => _saveTask(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor:  Color.fromARGB(255, 13, 5, 128), // Text color
        ),
        child: Text('Save',style: TextStyle(color: Colors.white)),
      ),
    ),
  ],
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
