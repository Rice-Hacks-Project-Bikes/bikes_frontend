import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class listBike extends StatefulWidget {
  const listBike({super.key});

  @override
  State<listBike> createState() => _listBikeState();
}

class _listBikeState extends State<listBike> {
  late XFile? _selectedImage;
  late String? make;
  late String? hourly;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedImage = null;
    make = "";
    hourly = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (_selectedImage != null && make != "" && hourly != "") {
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.check))
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Create Listing',
          style: TextStyle(color: Colors.black),
        ),
      ),
      /*body: 
      Container(
      child: SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 0.65,
      panel: Column(
        children: [Text("This is the sliding Widget"),] 
      ), ), */
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              final ImagePicker _picker = ImagePicker();
              XFile? image;
              // Pick an image

              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12)), //for the round edges
                builder: (context) {
                  return Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 200,
                      //specify height, so that it does not fill the entire screen
                      child: Column(children: [
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            child: const Text("Choose Image"),
                            onPressed: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                if (image != null) {
                                  _selectedImage = image;
                                }
                              });
                              // Dialog route
                              Navigator.pop(context);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          child: const Text("Take Photo"),
                          onPressed: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              if (image != null) {
                                _selectedImage = image;
                              }
                            });
                            // Dialog route
                            Navigator.pop(context);
                          },
                        )
                      ]));
                },
                context: context,
                isDismissible:
                    true, //boolean if you want to be able to dismiss it
                //boolean if something does not display, try that
              );
            },
            child: Container(
                padding: EdgeInsets.all(20),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: _selectedImage == null
                    ? Image.network(
                        "https://www.iconsdb.com/icons/preview/icon-sets/grey-wall/bike-2-xxl.png")
                    : Image.file(File(_selectedImage!.path),
                        key: ValueKey(_selectedImage),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Add a photo of your bike",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          // TakePhoto(),
          Container(
              padding: EdgeInsets.only(top: 10, left: 50, right: 50),
              child: TextField(
                onChanged: (value) => make = value,
                decoration:
                    InputDecoration(hintText: "What is the make of your bike?"),
              )),
          Container(
              padding: EdgeInsets.only(top: 10, left: 50, right: 50),
              child: TextField(
                onChanged: (value) => hourly = value,
                decoration: InputDecoration(
                    hintText: "How much do you want to charge per hour?"),
              )),
        ],
      ),
    );
  }
}

const List<String> list = <String>[
  "Men's Bicycle",
  "Women's Bicycle",
  "Children's Bicycle",
  "Recreational Bicycle"
];

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
      style: const TextStyle(color: Colors.deepPurple, fontSize: 20.0),
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
