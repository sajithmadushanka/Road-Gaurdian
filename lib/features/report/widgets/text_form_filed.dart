import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.text,
    required this.height,
    required this.controller,
    required this.maxLines,
  });

  final TextEditingController controller;
  final double height;
  final String text;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              ),
              style: const TextStyle(color: Colors.white),
              minLines: 1,
              maxLines: maxLines,
              keyboardType: TextInputType.multiline,
              validator: (value) =>
                  value!.isEmpty ? "Description required" : null,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 1.5,
            color: Colors.yellow[800],
          ),
        ],
      ),
    );
  }
}
