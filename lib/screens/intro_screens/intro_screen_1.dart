import 'package:google_solution_challenge/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({super.key});

  @override
  State<IntroScreen1> createState() => _IntroScreen1State();
}

class _IntroScreen1State extends State<IntroScreen1> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height * 0.33, // Ekran yüksekliğinin üçte biri kadar yükseklik
              width: double.infinity, // Genişlik tüm ekranı kaplar
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/yarrdım.jpg'),
                  fit: BoxFit.cover, // Resmi genişliğe sığacak şekilde boyutlandırır
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              LocaleKeys.openingCards1Title.tr(),
              style: const TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 35.0,
                  color: Color(0xFF2C3E50), // Mavi RENK
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              LocaleKeys.openingCards1.tr(),
              style: const TextStyle(
                fontFamily: "Source Sans Pro",
                fontSize: 18.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 30.0,
              width: 200.0,
              child: Divider(
                color: Colors.grey.shade200,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
