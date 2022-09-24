import 'package:bike_frontent/models/requests.dart';
import 'package:bike_frontent/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/bikes.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up for App"),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                List<Bike> bikes = BikeHttp().getBikesNearby();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPage(
                              bikesNearYou: bikes,
                            )));
                //_launchUrl
              },
              child: Text("Signin with SSO")),
        ));
  }
}

final Uri _url = Uri.parse('https://flutter.dev');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
