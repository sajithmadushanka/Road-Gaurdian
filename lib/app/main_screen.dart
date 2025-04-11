// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/features/home/view/home_screen.dart';
import 'package:road_gurdian/features/history/view/history_screen.dart';
import 'package:road_gurdian/features/profile/view/profile_screen.dart';
import 'package:road_gurdian/features/report/view/report_screen.dart';
import 'package:road_gurdian/features/setting/view/setting_screen.dart';

import 'package:road_gurdian/features/home/view_model/home_view_model.dart';
import 'package:road_gurdian/shared/layout/bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    ReportScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel()
            ..fetchUserProfile()
            ..fetchAllReports(),
        ),
      ],
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
