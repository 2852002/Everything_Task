import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final String? hintText;
  final int? maxLines;
  final bool readOnly;

  LabeledTextField({
    this.label,
    required this.controller,
    this.hintText,
    this.maxLines,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
