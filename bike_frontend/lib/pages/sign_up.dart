import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Center(
          child: Column(children: [
            SizedBox(height: 250.0),
            Image.network("https://socialimpact.com/wp-content/uploads/2021/03/logo-placeholder.jpg", height: 150.0,),
            Expanded(child: Container()),
            Padding(padding: EdgeInsets.only(bottom: 180.0), child: ElevatedButton(
              onPressed: _launchUrl, child: Text("Signin with SSO")))
          ],)
           

        ));
  }
}




final Uri _url = Uri.parse('https://flutter.dev');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
