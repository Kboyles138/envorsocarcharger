import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'chargeStation.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart' as maplauncher;
import 'package:flutter_svg/flutter_svg.dart';
import 'searchPage.dart';
import 'speech_recognition.dart' as speech;
//import 'newUser.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

// speech recognition
//String get speechRecognition => 'speech_recognition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

// Mapscreen widget
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

// Mapscreen state
class _MapScreenState extends State<MapScreen> {
  // Location data
  late LocationData currentLocation;
  late LocationData _currentPosition;
  Location location = Location();
  // Charger data
  Chargers chargers = Chargers();
  List<Map<String, dynamic>> chargerData = [];
  List<Marker> markers = [];
  // Google Maps data
  late GoogleMapController _googleMapController;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(46.999843, -120.539261), // Lat/Long target.
    zoom: 11.5, // Max zoom level is normally 21.
  );
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  // Called upon state initialization
  void initState() {
    super.initState();
    _fillChargerList();
  }

  @override
  // Generate map view
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //getStation();
    return Scaffold(
        // Google Map component values
        body: Stack(children: [
      // Google Map
      Positioned.fill(
          child: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: Set.of(markers), // Displays markers
      )),
      // Recenter button
      Positioned(
          right: 30,
          bottom: 150,
          child: FloatingActionButton(
            backgroundColor: Color(0xff096B72),
            foregroundColor: Colors.white,
            onPressed: () => getLocation(_googleMapController),
            child: const Icon(Icons.center_focus_strong),
            heroTag: 'center',
          )),
      // Back button
      Positioned(
          left: 20,
          top: 50,
          child: FloatingActionButton(
            backgroundColor: Color(0xff096B72),
            foregroundColor: Colors.white,
            onPressed: () => Navigator.pop(context),
            heroTag: 'back',
            child: const Icon(Icons.arrow_back),
          )),
      // THIS IS ALL SEARCH BAR STUFF PLEASE DON'T TOUCH D:
      // If you do touch, please contact Kirsten, its sensitive :)
      Positioned(
          left: 0,
          bottom: 0,
          child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: screenWidth / 1.18,
                    height: 105,
                    decoration: BoxDecoration(
                      color: Color(0xff096B72),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(children: [
                      Row(children: [
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextButton.icon(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(10, 0, 0, 0)),
                              alignment: Alignment.centerLeft,
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            label: Text('Search',
                                style: TextStyle(color: Colors.grey)),
                            onPressed: () {
                              Navigator.of(context).push(_createRoute());
                            },
                          ),
                        ),
                        Container(
                            child: ElevatedButton(
                          onPressed: () {
                            speech.main();
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const speech )
                          },
                          child: Icon(Icons.mic),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder()),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8)),
                            backgroundColor: MaterialStateProperty.all(
                                Color(0xff732015)), // Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.black; // Splash color
                            }),
                          ),
                        )),
                      ]),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                              padding: EdgeInsets.all(2),
                              width: 280,
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                ),
                              ))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          TextButton.icon(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            label: (Text('My locations',
                                style: TextStyle(color: Colors.white))),
                            onPressed: () {},
                          ),
                          Container(
                              padding: EdgeInsets.all(2),
                              width: 1,
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border(
                                left: BorderSide(
                                  color: Colors.white,
                                ),
                              ))),
                          TextButton.icon(
                            icon: Icon(Icons.directions_car_filled_rounded,
                                color: Colors.white),
                            label: (Text('Trip Planner',
                                style: TextStyle(color: Colors.white))),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 33,
                          )
                        ],
                      )
                    ]),
                  ),
                ],
              )))
    ]));
  }

  // Opens the map launcher (not yet binded)
  openMapsSheet(context) async {
    try {
      final coords =
          maplauncher.Coords(37.759392, -122.5107336); // Set charger coords
      final title = "Charger"; // Set charger title here
      final availableMaps = await maplauncher.MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Set the location before the map is rendered (WIP)
  void initializeLocation() async {
    _currentPosition = await location.getLocation();
  }

  // Recenters the map on the user's location
  void getLocation(GoogleMapController controller) async {
    // Wait for location
    currentLocation = await location.getLocation();
    // Move map camera
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      zoom: 17.0,
    )));
  }

  // Launches a pin in Google Maps (Provide more later)
  void launchMap(int markerInd) async {
    final availableMaps = await maplauncher.MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: maplauncher.Coords(
          chargerData[markerInd]['lat'], chargerData[markerInd]['lon']),
      title: (chargerData[markerInd]['network'] + "Charger location"),
      description: "Level 2 charger, Greenlots",
    );

    if (await maplauncher.MapLauncher.isMapAvailable(
            maplauncher.MapType.google) !=
        null) {
      await maplauncher.MapLauncher.showMarker(
          mapType: maplauncher.MapType.google,
          coords: maplauncher.Coords(
              chargerData[markerInd]['lat'], chargerData[markerInd]['lon']),
          title: (chargerData[markerInd]['network'] + " Charger"),
          description: "Level 2 charger, Greenlots");
    }
  }

  // Populate charger data list.
  // TO DO: use unique keys for recalculating
  _fillChargerList() async {
    // Pull data
    chargerData = await chargers.pullChargers(46.999843, -120.539261);

    // Print the lat and long of every charger
    for (int i = 0; i < chargerData.length; i++) {
      print("lat: ${chargerData[i]['lat']}");
      print("lon: ${chargerData[i]['lon']}");

      LatLng pos = LatLng(chargerData[i]['lat'], chargerData[i]['lon']);
      setState(() {
        markers.add(Marker(
          markerId: (MarkerId(markers.length.toString())),
          position: pos,
          onTap: () => launchMap(i),
        ));
      });
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const searchPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
