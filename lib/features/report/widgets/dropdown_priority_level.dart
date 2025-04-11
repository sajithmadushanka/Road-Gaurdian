import 'package:flutter/material.dart';

class DropdownPriorityLevel extends StatelessWidget {
  final Function(String?) onChanged;

  const DropdownPriorityLevel({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Priority Level',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'High',
          child: Text('High'),
        ),
        DropdownMenuItem(
          value: 'Medium',
          child: Text('Medium'),
        ),
        DropdownMenuItem(
          value: 'Low',
          child: Text('Low'),
        ),
      ],
      onChanged: onChanged,
    );
  }
}