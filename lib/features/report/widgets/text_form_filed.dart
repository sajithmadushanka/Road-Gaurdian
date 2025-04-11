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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? const Color(0xFF2A2A2A)
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
                hintStyle: TextStyle(
                  color:
                      isDarkMode
                          ? Colors.grey
                          : const Color.fromARGB(255, 20, 20, 20),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              minLines: 1,
              maxLines: maxLines,
              keyboardType: TextInputType.multiline,
              validator:
                  (value) => value!.isEmpty ? "Description required" : null,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 1.5,
            color:
                isDarkMode
                    ? Colors.yellow[800]
                    : Theme.of(
                      context,
                    ).primaryColor, // You can set any color for light mode
          ),
        ],
      ),
    );
  }
}
