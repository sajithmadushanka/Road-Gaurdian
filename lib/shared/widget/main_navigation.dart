import 'package:flutter/material.dart';
import 'package:road_gurdian/app/routes.dart';
import 'package:road_gurdian/features/home/view/home_screen.dart';
import 'package:road_gurdian/features/history/view/history_screen.dart';
import 'package:road_gurdian/features/report/view/report_screen.dart';
import 'package:road_gurdian/features/profile/view/profile_screen.dart';
import 'package:road_gurdian/features/setting/view/setting_screen.dart';
import 'package:road_gurdian/shared/layout/bottom_nav.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Each tab gets its own navigator key to maintain its own navigation stack.
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  // For each tab, define the initial screen.
  final List<Widget> _screens = [
    HomeScreen(),
    HistoryScreen(),
    ReportScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  // When a new tab is selected, if you are already on that tab,
  // you could choose to pop to the initial route.
  void _onTabTapped(int index) {
    if (_currentIndex == index) {
      _navigatorKeys[index]
          .currentState
          ?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Notice we leave out an appBar since each nested screen provides its own.
      body: Stack(
        children: List.generate(_screens.length, (index) {
          return Offstage(
            offstage: _currentIndex != index,
            child: Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (RouteSettings settings) {
                // Here you can add additional route settings if needed
                return MaterialPageRoute(
                  builder: (_) => _screens[index],
                );
              },
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        // Instead of pushing named routes directly, pass a callback.
        onTap: _onTabTapped,
      ),
    );
  }
}
