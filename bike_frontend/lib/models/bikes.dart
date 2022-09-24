class Bike {
  String make;
  Position location;
  String image;
  double hourlyRate;
  bool inUse;

  Bike(
      {required this.make,
      required this.location,
      required this.image,
      required this.hourlyRate,
      required this.inUse});
}

class Position {
  double latitude;
  double longitude;

  Position({required this.latitude, required this.longitude});
}
