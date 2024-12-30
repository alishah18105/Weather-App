import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/Screens/Home%20Screen/homeScreen_view.dart';

class SplashScreenViewModel extends BaseViewModel {

  void StartUp(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
    });
  }
}
