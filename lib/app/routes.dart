import 'package:flutter/material.dart';
import 'package:road_gurdian/features/auth/view/forgotpassword_screen.dart';
import 'package:road_gurdian/features/auth/view/signin_screen.dart';
import 'package:road_gurdian/features/auth/view/signup_screen.dart';
import 'package:road_gurdian/features/history/view/history_screen.dart';
import 'package:road_gurdian/features/home/view/home_screen.dart';
import 'package:road_gurdian/features/profile/view/profile_screen.dart';
import 'package:road_gurdian/features/report/view/report_screen.dart';
import 'package:road_gurdian/features/setting/view/setting_screen.dart';
import 'package:road_gurdian/features/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String forgotpassword = '/forgotpassword';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String addReport = '/addReport';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotpassword:
        return MaterialPageRoute(builder: (_) => const ForgotpasswordScreen());
      case history:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case addReport:
        return MaterialPageRoute(builder: (_) => const ReportScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
