import 'package:flutter/material.dart';

class AuthBtn extends StatelessWidget {
  const AuthBtn({super.key, this.onPressed, required this.btnName});
  final VoidCallback? onPressed;
  final String btnName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        btnName,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
      ),
    );
  }
}
