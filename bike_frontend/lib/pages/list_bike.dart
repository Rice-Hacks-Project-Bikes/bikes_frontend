import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bike_frontent/pages/map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:bike_frontent/pages/camera_screen.dart';

import '../models/bikes.dart';
import '../models/requests.dart';

class list_bike extends StatelessWidget {
  const list_bike({super.key});
  
  get firstCamera => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your bicycle listing'),
      ),
      /*body: 
      Container(
      child: SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 0.65,
      panel: Column(
        children: [Text("This is the sliding Widget"),] 
      ), ), */
      body:
      Column( 
        children: [
          Container(
            padding: EdgeInsets.all(60.0),
            child: ElevatedButton(
          style: TextButton.styleFrom(
          padding: EdgeInsets.all(20.0),
          ),
          onPressed: () async {
                List<Bike> bikes = BikeHttp().getBikesNearby();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPage(
                              bikesNearYou: bikes,
                            )));
            
          },
          child: const Text('Where is your bike?',
          style: TextStyle(fontSize: 20.0),),
        ),),
         Container(
          padding: EdgeInsets.all(20.0),
          child: ElevatedButton( 
            onPressed: () {CameraScreen();
            }, 
            child: const Text('Upload a photo of your bike here',
            style: TextStyle( fontSize: 20.0),)
            
          )),
         // TakePhoto(),
          Container(
            padding: EdgeInsets.all(50.0),
            child: Bikecategory()),
          const Spacer(),
          Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(60.0),
        margin: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('List your bicycle',
          style: TextStyle( fontSize: 20.0)),
        ),
      ),
      ],
    ),
      ); 
  }
}
const List<String> list = <String>["Men's Bicycle", "Women's Bicycle", "Children's Bicycle", "Recreational Bicycle"];

class Bikecategory extends StatefulWidget {
  const Bikecategory({super.key});

  @override
  State<Bikecategory> createState() => _BikecategoryState();
}

class _BikecategoryState extends State<Bikecategory> {
  String? dropdownValue = null;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text("Select Bicycle Type"), //not working does it matter?
      itemHeight: 50.0,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: 
      const TextStyle(color: Colors.deepPurple, fontSize: 20.0),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? bicyclevalue) {
        // This is called when the user selects an item. 
        setState(() {
          dropdownValue = bicyclevalue!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//TO DO: Add camera request or access to upload photo of bike?
//TO DO: Add Location button and have it open google maps to drop or pin? 
//OR have it use location services on device

