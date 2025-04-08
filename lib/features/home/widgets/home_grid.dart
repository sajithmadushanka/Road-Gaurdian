import 'package:flutter/material.dart';
import 'package:road_gurdian/features/home/widgets/home_card.dart';

class HomeGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.report, 'title': 'Report', 'route': '/report'},
    {'icon': Icons.map, 'title': 'Track Bus', 'route': '/track'},
    {'icon': Icons.history, 'title': 'History', 'route': '/history'},
    {'icon': Icons.person, 'title': 'Profile', 'route': '/profile'},
  ];

  HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return GridView.count(
      crossAxisCount: isTablet ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      children: items.map((item) {
        return HomeCard(
          icon: item['icon'],
          title: item['title'],
          onTap: () => Navigator.pushNamed(context, item['route']),
        );
      }).toList(),
    );
  }
}
