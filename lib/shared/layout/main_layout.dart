// // lib/shared/layout/main_layout.dart

// import 'package:flutter/material.dart';
// import 'package:road_gurdian/shared/widget/app_bar.dart';
// import 'bottom_nav.dart';

// class MainLayout extends StatelessWidget {
//   final Widget child;
//   final int currentIndex;
//   final appBarTitle;

//   const MainLayout({
//     super.key,
//     required this.child,
//     required this.currentIndex,
//     required this.appBarTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(title: appBarTitle),
      
//       body: child,
//       bottomNavigationBar: BottomNavBar(currentIndex: currentIndex),
//     );
//   }
// }
