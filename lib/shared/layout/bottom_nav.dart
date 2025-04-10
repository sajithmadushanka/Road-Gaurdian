import 'package:flutter/material.dart';
import 'package:road_gurdian/app/routes.dart';
import 'package:road_gurdian/features/report/view/add_report_popup.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.purple,
      backgroundColor: const Color.fromARGB(255, 230, 204, 235),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      iconSize: 24,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      selectedIconTheme: const IconThemeData(size: 30),
      unselectedIconTheme: const IconThemeData(size: 24),
      elevation: 8,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.history);
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.addReport);

            break;
          case 3:
            Navigator.pushNamed(context, AppRoutes.settings);
            break;
          case 4:
            Navigator.pushNamed(context, AppRoutes.profile);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "history"),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, color: Colors.white, size: 40),
          label: "Add a Report",
          backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
