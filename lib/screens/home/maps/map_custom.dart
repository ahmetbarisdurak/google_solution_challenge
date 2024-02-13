import 'package:custom_info_window/custom_info_window.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_solution_challenge/translations/locale_keys.g.dart';


class MapUIcustom extends StatefulWidget {
  const MapUIcustom({super.key});

  @override
  State<MapUIcustom> createState() => _MapUIStatecustom();
}

class _MapUIStatecustom extends State<MapUIcustom> {
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final LatLng _latLng = const LatLng(28.7041, 77.1025);
  final double _zoom = 15.0;
  int i_mar = 0;
  bool mapToggle = false;
  var currentLocation;

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((currLoc) {
      setState(() {
        currentLocation = currLoc;
        mapToggle = true;

        markStatus();
        i_mar = _markers.length;

        markSOS();

        // Gerek olmayabilir bu kısma.
        //populateClients_safeArea();
      });
    });
  }

  final Set<Marker> _markers = {};
  final List<LatLng> _latLang = <LatLng>[
    const LatLng(38.4237, 27.1428),
    const LatLng(41.0082, 28.9784)
  ];

  populateClients_safeArea() {
    //clients=[];
    FirebaseFirestore.instance.collection("markers").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          //clients.add(docs.docs[i].data);
          loadData_safeArea(docs.docs[i].data, i + i_mar);
        }
      }
    });
  }

  loadData_safeArea(latLang, i) {
    _markers.add(
      Marker(
        markerId: MarkerId("$i"),
        position: LatLng(
            latLang()['location'].latitude, latLang()['location'].longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(latLang()['image']),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: const Color.fromARGB(255, 255, 197, 146)),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            latLang()['clientName'],
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        const Spacer(),
                        const Text("!!!")
                      ],
                    ),
                  ),
                  Padding(
                      padding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        latLang()['snippet'],
                        maxLines: 2,
                      ))
                ],
              ),
            ),
            LatLng(latLang()['location'].latitude,
                latLang()['location'].longitude),
          );
        },
      ),
    );
    setState(() {});
  }

  markStatus() {
    print("Populating Status");

    FirebaseFirestore.instance.collection("Status").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          loadData(docs.docs[i].data, i, "yellow"); // Since it is status, it should be yellow.
        }
      }
    });
  }

  markSOS() {
    print("Populating SOS");

    FirebaseFirestore.instance.collection('SOS').get().then((docs) {
      if (docs.docs.isNotEmpty) {

        for (int i = 0; i < docs.docs.length; ++i) {
          loadData(docs.docs[i].data, i + i_mar, "red"); // Since it is a SOS, it should be red.
        }
      }
    });
  }

  loadData(latLang, i, color) {

    BitmapDescriptor markerColor = BitmapDescriptor.defaultMarker; // Varsayılan renk

    if (color == "yellow") {
      markerColor = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    }
    else if( color == "red") {
      markerColor = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);


      print(latLang()['status']);
      print(latLang()['location']);
    }


    _markers.add(
      Marker(
        markerId: MarkerId("$i"),
        position: LatLng(latLang()['location'].latitude, latLang()['location'].longitude),
        icon: markerColor, // Renk ataması
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Color.fromARGB(255, 255, 197, 146)),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            latLang()['status'], // normalde ismi address
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        const Spacer(),
                        const Text("!!!")
                      ],
                    ),
                  ),
                  Padding(
                      padding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        latLang()['status'],
                        maxLines: 2,
                      ))
                ],
              ),
            ),
            LatLng(latLang()['location'].latitude,
                latLang()['location'].longitude),
          );
        },
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    markStatus();

    i_mar = _markers.length;
    markSOS();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,
        title: Text(
          LocaleKeys.maps_title.tr(),
          style: GoogleFonts.prozaLibre(
            color: const Color(0xffe97d47),
            fontSize: 25,
            fontWeight: FontWeight.w600,
            height: 1.355,
          )
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            markers: _markers,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.5753, 36.9228),
              zoom: 5,
            ),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
