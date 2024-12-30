import 'package:flutter/material.dart';
import 'package:weather_app/Screens/Splash%20Screen/splashScreen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView() ,
    );
  }
}