import 'package:google_solution_challenge/screens/intro_screens/intro_screen_1.dart';
import 'package:google_solution_challenge/screens/intro_screens/intro_screen_2.dart';
import 'package:google_solution_challenge/screens/intro_screens/intro_screen_3.dart';
import 'package:google_solution_challenge/screens/intro_screens/intro_screen_4.dart';
import 'package:google_solution_challenge/screens/login/login_page.dart';
import 'package:google_solution_challenge/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
              IntroScreen4(),
            ],
          ),
          Positioned(
            bottom: height * 0.05, // 1) Butonların daha aşağıda yer alması için değer ayarlandı
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: Colors.blueAccent,
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                    ),
                  ),
                ),
                onLastPage
                    ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildButton(
                        () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    ),
                    LocaleKeys.OnBoarding_Done.tr(),
                    Colors.blue.shade700, // 2) Buton rengi değiştirildi
                    Colors.white,
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildButton(
                        () => _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    LocaleKeys.OnBoarding_Next.tr(),
                    Colors.blue.shade700, // 2) Buton rengi değiştirildi
                    Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildButton(
                    onLastPage
                        ? () {}
                        : () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    ),
                    LocaleKeys.OnBoarding_Skip.tr(),
                    Colors.white,
                    onLastPage ? Colors.white : Colors.blue.shade700, // 2) Buton rengi değiştirildi
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(
      Function() onTap, String text, Color buttonColor, Color textColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.0,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

