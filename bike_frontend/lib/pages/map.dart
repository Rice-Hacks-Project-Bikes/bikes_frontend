import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:link/components/hangoutContainer.dart';
// import 'package:link/components/listtile.dart';
// import 'package:link/models/friendsList.dart';
// import 'package:link/models/hangoutList.dart';
// import 'package:link/models/hangouts.dart';
// import 'package:link/models/user.dart';
// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
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
                      })
                ]);
              }
              return CircularProgressIndicator();
            })
            // SlidingUpPanel(
            //     maxHeight: MediaQuery.of(context).size.height * 0.65,
            //     borderRadius: BorderRadius.all(Radius.circular(25)),
            //     panel: Column(
            //       children: [
            //         UserTile(
            //           userObject: Provider.of<User>(context),
            //           user: true,
            //         ),
            //         Expanded(
            //             child: ListView(
            //           // itemExtent: 3,
            //           children: [
            //             ListView.builder(
            //                 physics: NeverScrollableScrollPhysics(),
            //                 // scrollDirection: Axis.vertical,
            //                 shrinkWrap: true,
            //                 itemCount: Provider.of<User>(context)
            //                         .userOwnedHangouts
            //                         ?.length ??
            //                     0,
            //                 itemBuilder: (context, index) {
            //                   return HangoutContainer(
            //                     hangouts: Provider.of<HangoutList>(context)
            //                         .returnHangoutsById(Provider.of<User>(context)
            //                             .userOwnedHangouts)[index],
            //                   );
            //                 }),
            //             ListView.builder(
            //                 physics: NeverScrollableScrollPhysics(),
            //                 // scrollDirection: Axis.vertical,
            //                 shrinkWrap: true,
            //                 itemCount:
            //                     Provider.of<User>(context).friendsId.length,
            //                 itemBuilder: (context, index) {
            //                   // print(Provider.of<User>(context).friendsId);
            //                   return UserTile(
            //                     userObject: Provider.of<FriendsList>(context)
            //                         .getFriendsById(Provider.of<User>(context)
            //                             .friendsId)[index],
            //                     user: false,
            //                   );
            //                 })
            //           ],
            //         ))
            //       ],
            //     ))

            ));
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
