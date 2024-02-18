import 'package:google_solution_challenge/screens/home_screens/earthquaker/home_page.dart';
import 'package:google_solution_challenge/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'home_screens/maps/map_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          LocaleKeys.Home_HomePage.tr(),
          style: GoogleFonts.prozaLibre(
            color: Colors.blueGrey,
            fontSize: 25,
            fontWeight: FontWeight.w600,
            height: 1.355,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                // BLOOD BUTTON
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const EarthquakerPage()));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    fixedSize: const Size(300, 95),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    elevation: 15,
                    shadowColor: Colors.blueGrey,
                    side: const BorderSide(color: Color(0xffe97d47), width: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))), child: null,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                // BE VOLUNTEER
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EarthquakerPage()));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    fixedSize: const Size(300, 95),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    elevation: 15,
                    shadowColor: const Color(0xffe97d47),
                    side: const BorderSide(color: Color(0xffe97d47), width: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))), child: null,
                // BE VOLUNTEER
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                // BOX BUTTON
                //icon: Icon(Icons.wallet_giftcard_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EarthquakerPage()));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    fixedSize: const Size(300, 95),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    elevation: 15,
                    shadowColor: const Color(0xffe97d47),
                    side: const BorderSide(color: Color(0xffe97d47), width: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))), child: null,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                // MAPS
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MapUIcustom()));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    fixedSize: const Size(300, 95),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    elevation: 15,
                    shadowColor: const Color(0xffe97d47),
                    side: const BorderSide(color: Color(0xffe97d47), width: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))),
                // MAPS
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/map_black.png",
                        width: 75,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(LocaleKeys.Home_Maps.tr(),),
                      //SizedBox(width: 75,),
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
