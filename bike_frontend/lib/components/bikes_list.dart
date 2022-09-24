import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/bikes.dart';

class BikesList extends StatelessWidget {
  final List<Bike> bikes;
  const BikesList({Key? key, required this.bikes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: bikes.length,
        shrinkWrap: true,
        itemBuilder: (((context, index) => bikes[index].bikeListTile())));
  }
}
