import 'package:flutter/material.dart';
import 'package:road_gurdian/features/home/view_model/home_view_model.dart';
import 'package:road_gurdian/features/home/widgets/home_grid.dart';
import 'package:road_gurdian/shared/layout/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    viewModel.fetchUser();

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${viewModel.userName}!"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            HomeGrid(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
