import 'package:bike_frontent/components/bikes_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:link/components/hangoutContainer.dart';
// import 'package:link/components/listtile.dart';
// import 'package:link/models/friendsList.dart';
// import 'package:link/models/hangoutList.dart';
// import 'package:link/models/hangouts.dart';
// import 'package:link/models/user.dart';
// import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';

import '../models/bikes.dart';

// ignore: must_be_immutable
class MapPage extends StatelessWidget {
  List<Bike> bikesNearYou;

  MapPage({Key? key, required this.bikesNearYou}) : super(key: key);

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    print(bikesNearYou);
    return Scaffold(
        body: FutureBuilder(
            future: checkPerms(),
            builder: ((BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return Stack(children: <Widget>[
                  StreamBuilder(
                      stream: Geolocator.getPositionStream(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.hasError) {
                          print("Error!");
                          return new Text("Error!");
                        } else if (asyncSnapshot.data == null) {
                          print("no location");
                          return Text("no location");
                        } else {
                          List locationData = asyncSnapshot.data
                              .toString()
                              .split(':')
                              .join(',')
                              .split(',');
                          double lat = double.parse(locationData[1]);
                          double long = double.parse(locationData[3]);
                          //_setMarkers(LatLng(lat, long));
                          return GoogleMap(
                            // markers: Market,
                            myLocationEnabled: true,
                            compassEnabled: true,

                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(lat, long),
                              zoom: 13,
                            ),
                            //markers: _markers,
                          );
                        }
                      }),
                  SlidingUpPanel(
                      maxHeight: MediaQuery.of(context).size.height * 0.65,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      panel: Column(
                        children: [
                          Text("Bikes in Your Area"),
                          BikesList(bikes: bikesNearYou)
                        ],
                      ))
                ]);
              }
              return const CircularProgressIndicator();
            })));
  }
}

Future<bool> checkPerms() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return true;
}
