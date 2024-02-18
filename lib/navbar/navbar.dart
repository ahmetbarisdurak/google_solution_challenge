import 'dart:math';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_solution_challenge/controller/controller.dart';
import 'package:google_solution_challenge/screens/home_screens/earthquaker/home_page.dart';
import 'package:google_solution_challenge/screens/home_screens/maps/map_custom.dart';
import 'package:google_solution_challenge/screens/home_screens//camera/CameraHome.dart';
import 'package:google_solution_challenge/screens/profile/sos_rev.dart';
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  double _latitude = 36.2025833;
  double _longitude = 36.1604033, distance = 0, earthLatitude = 0, earthLongitude = 0;
  List<CameraDescription>? cameras;

  late LatLng _currentPostion = const LatLng(38.9637, 35.2433);
  late GeoPoint _EarthPostion = const GeoPoint(36.2025833, 36.1604033);

  FirebaseDocument() async {  // Yakında bir deprem olduysa bir pop up olarak gösterebiliriz hemen.
    var document = await db
        .collection('EarthquakeLocation')
        .doc("mpQ3qaUnmo54pPKPu30W")
        .get();

    Map<String, dynamic>? value = document.data();
    if (mounted && value != null) {
      setState(() {
        _EarthPostion = value['Hatay'];
        earthLatitude = _EarthPostion.latitude;
        earthLongitude = _EarthPostion.longitude;
        distance = evalDistance(_latitude, _longitude, earthLatitude, earthLongitude);
      });
      // Eğer belirli bir mesafenin altındaysa (örneğin 0.1 derece), uyarı göster
      if (distance < 10) {
        _showEarthquakeAlert();
      }
    }
  }

  void _showEarthquakeAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deprem Uyarısı!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Yakınınızda bir deprem meydana geldi.'), // locale keys kısmına eklenecek
                Text('Lütfen güvenli bir yere gidin ve talimatları takip edin.'), // locale keys kısmına eklenecek
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'), // locale keys kısmına eklenecek.
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double evalDistance(latitude, longitude, earthLatitude, earthLongitude) {
    double dst = sqrt((earthLatitude - latitude) * (earthLatitude - latitude) +
        (earthLongitude - longitude) * (earthLongitude - longitude));
    return dst;
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));

    setState(() {
      _currentPostion = LatLng(position.latitude, position.longitude);
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  @override
  void initState() {
    _getUserLocation();
    FirebaseDocument();
    super.initState();
    availableCameras().then((availableCameras) {
      setState(() {
        cameras = availableCameras;
      });
    });
  }

  final controller = Get.put(NavBarController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (context) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: [
              const EarthquakerPage(),
              const SOSButton(),
              // const ARPage(), // AR page
              CameraHomePage(cameras!), // kamera buraya gelecek
              const MapUIcustom(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: GNav(
                selectedIndex: controller.tabIndex,
                onTabChange: controller.changeTabIndex,
                backgroundColor: Colors.transparent,
                color: Colors.black,
                activeColor: Colors.white,
                tabBackgroundColor: const Color.fromARGB(43, 233, 125, 71),
                gap: 10.0,
                padding: const EdgeInsets.all(16.0),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: Icons.add_alert,
                    text: "SOS",
                  ),
                  GButton(
                    icon: Icons.vrpano,
                    text: "AR",
                  ),
                  GButton(
                    icon: Icons.camera_alt,
                    text: "Camera",
                  ),
                  GButton(
                    icon: Icons.map,
                    text: "Maps",
                  ),
                ],
              ),
            ),
          ),
        );
    });
  }
}
