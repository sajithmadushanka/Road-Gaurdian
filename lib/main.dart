import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/app.dart';
import 'package:road_gurdian/features/auth/view_model/auth_view_model.dart';
import 'package:road_gurdian/features/history/view_model/history_view_model.dart';
import 'package:road_gurdian/features/home/view_model/home_view_model.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/firebase_options.dart';
import 'package:road_gurdian/shared/theme/theme_provider.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //  Preserve the native splash screen until ready---------
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //  Remove splash screen after init---------
  FlutterNativeSplash.remove();

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
