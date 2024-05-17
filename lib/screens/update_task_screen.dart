import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/labeled_text_field.dart';
import 'package:table_calendar/table_calendar.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;

  UpdateTaskScreen({required this.task});

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  DateTime? _startRangeDate;
  DateTime? _endRangeDate;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _selectedDate = widget.task.date;
    super.initState();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _updateTask() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }

    final updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate,
      endDate: _selectedDate,
    );

    Provider.of<TaskProvider>(context, listen: false)
        .updateTask(widget.task.id, updatedTask);
    // Notify listeners after updating the task
    Provider.of<TaskProvider>(context, listen: false).notifyListeners();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
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
                  controller: _titleController,
                ),
                SizedBox(height: 20),
                LabeledTextField(
                  hintText: 'Task description',
                  controller: _descriptionController,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _updateTask,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16), backgroundColor:Color.fromARGB(255, 13, 5, 128),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Update',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
}