import 'package:google_solution_challenge/screens/explore/explore.dart';
import 'package:google_solution_challenge/screens/home/earthquaker/post_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_solution_challenge/screens/profile/profile_screen.dart';
import 'package:google_solution_challenge/services/report_service.dart';
import 'package:google_solution_challenge/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EarthquakerPage extends StatefulWidget {
  const EarthquakerPage({super.key});
  @override
  State<EarthquakerPage> createState() => _EarthquakerPageState();
}

class _EarthquakerPageState extends State<EarthquakerPage> {
  final ReportService _reportService = ReportService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person), // Profile girmek için olan buton
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen())),
          color: const Color(0xffe97d47),
        ),
        backgroundColor: Colors.transparent,
        title: Center( // Programın isminin yazdığı kısım
          child: Text(
            LocaleKeys.earthquaker_title.tr(),
            style: GoogleFonts.prozaLibre(
              color: const Color(0xffe97d47),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.355,
            ),
          ),
        ),
        actions: [
          IconButton( // Explore butonu, deprem hakkında bilgilendirmeler veriyor.
            icon: const Icon(Icons.search_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ExploreScreen())),
            color: const Color(0xffe97d47),
          ),
        ],
      ),
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text(
              LocaleKeys.make_your_voice_heard_reports.tr(), // Rapor isimleri
              style: const TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Divider(),
          ),
          StreamBuilder(
            stream: _reportService.getStatus(),


            builder: (context, snapshot) {

              if(!snapshot.hasData) {
                return const Center( // CircularProgressIndicator'ı merkeze al
                  child: SizedBox(
                    width: 40, // Yüklenme göstergesinin genişliği
                    height: 40, // Yüklenme göstergesinin yüksekliği
                    child: CircularProgressIndicator(
                      color: Color(0xffe97d47),
                    ),
                  ),
                );
              }
              else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot myReport = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        margin: const EdgeInsets.fromLTRB(3, 0, 3, 9),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                          "assets/images/profile_black.png"),
                                      const SizedBox(width: 10),
                                      Text(
                                        myReport['user'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    myReport['createdAt']
                                        .toDate()
                                        .toString()
                                        .substring(0, 10),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                myReport['status'],
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625,
                                  color: const Color(0xff000000),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.share),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () async {
                                      GeoPoint point =
                                      myReport['location'];
                                      final map =
                                          'https://www.google.com/maps/search/?api=1&query=${point.latitude},${point.longitude}';
                                      if (await (canLaunch(map))) {
                                        await launch(map);
                                      }
                                    },
                                    icon: const Icon(Icons.location_on),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Go to CartPage
        heroTag: const Text("btn1"),
        backgroundColor: Colors.black,
        onPressed: () {
          showOptions(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
