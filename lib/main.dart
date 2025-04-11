import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/app.dart';
import 'package:road_gurdian/features/auth/view_model/auth_view_model.dart';
import 'package:road_gurdian/features/history/view_model/history_view_model.dart';
import 'package:road_gurdian/features/home/view_model/home_view_model.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/firebase_options.dart';
import 'package:road_gurdian/shared/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel()..fetchUserProfile(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryViewModel()..fetchUserReports(),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
