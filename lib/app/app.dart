import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/routes.dart';
import 'package:road_gurdian/shared/theme/app_theme.dart';
import 'package:road_gurdian/shared/theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Road Guardian',
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.signin,
      
    );
  }
}
