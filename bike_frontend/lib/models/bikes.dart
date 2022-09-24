import 'package:flutter/material.dart';

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

  Color inUseColor() {
    return inUse ? Colors.grey : Colors.green;
  }

  Widget bikeListTile() {
    return ListTile(
      leading: Image.network(image),
      title: Text(make),
      subtitle: Text(hourlyRate.toString()),
      trailing: Container(
        decoration: BoxDecoration(
            color: inUseColor(), borderRadius: BorderRadius.circular(20)),
        height: 20,
        width: 20,
      ),
    );
  }
}

class Position {
  double latitude;
  double longitude;

  Position({required this.latitude, required this.longitude});
}
