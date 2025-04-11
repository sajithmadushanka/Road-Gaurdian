import 'package:flutter/material.dart';
import 'package:road_gurdian/app/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(image: imageAsset('assets/images/logo.png')),
            const Text('Welcome to Road Guardian'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.main);

              },
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }
}
