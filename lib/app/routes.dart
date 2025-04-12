// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:road_gurdian/app/main_screen.dart';
import 'package:road_gurdian/features/splash/view/splash_screen.dart';
import 'package:road_gurdian/features/auth/view/signin_screen.dart';
import 'package:road_gurdian/features/auth/view/signup_screen.dart';
import 'package:road_gurdian/features/auth/view/forgotpassword_screen.dart';
import 'package:road_gurdian/features/admin/view/admin_dashboard.dart';

class AppRoutes {
  static const String splash = '/';
  static const String main = '/main';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String forgotpassword = '/forgotpassword';
  static const String adminDashboard = '/adminDashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotpassword:
        return MaterialPageRoute(builder: (_) => const ForgotpasswordScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
