import 'bikes.dart';

class BikeHttp {
  List<Bike> getBikesNearby() {
    return [
      Bike(
          make: "Linus",
          image:
              "https://pyxis.nymag.com/v1/imgs/b77/dcc/1c113a0a7e93c6409665231ea5329a3336-linus-roadster-sport-green.jpg",
          inUse: false,
          location: Position(latitude: 29.717394, longitude: -95.401833),
          hourlyRate: 12)
    ];
  }
}
