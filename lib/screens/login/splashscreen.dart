import 'package:google_solution_challenge/screens/login/login_page.dart';
import 'package:google_solution_challenge/screens/onboardingscreen.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? "onboard" : "home",
      routes: {
        "onboard": (context) => const OnBoardingScreen(), // Onboard screen'e yönlendiriyor. Sırayla intro screenler gösterilir.
        "home": (context) => const MainPage(), // Main page yönlendiriyor.
      },
    );
  }
}
