import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/Screens/Splash%20Screen/splashScreen_viewModel.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onViewModelReady: (viewModel) => viewModel.StartUp(context),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3A0CA3), // Dark Purple
              Color(0xFF7209B7), // Medium-Dark Purple
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Lottie.asset("assets/images/splash_screen.json"),
                width: 200,
                height: 200,
              ),
            ),
          ),
        );
      },
    );
  }
}
