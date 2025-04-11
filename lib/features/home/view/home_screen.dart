// lib/features/home/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:road_gurdian/features/home/widgets/home_screen_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenContent(); // No Provider here
  }
}
