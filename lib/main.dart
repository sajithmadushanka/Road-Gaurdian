import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/app.dart';
import 'package:road_gurdian/features/report/view_model/report_view_model.dart';
import 'package:road_gurdian/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

