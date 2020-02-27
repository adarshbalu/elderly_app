import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/home_screen_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker/place_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactScreen extends StatefulWidget {
  static const String id = 'Contact_Screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double screenWidth = deviceInfo.size.width;
    double screenHeight = deviceInfo.size.height;

    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("Pick Delivery location"),
          onPressed: () {
            showPlacePicker(context);
          },
        ),
      ),
    );
  }

  void showPlacePicker(BuildContext context) async {
    LatLng customLocation;

    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyBRSjFpkj9vWq4ETzy-mG5fCmhleGPdmnY",
          displayLocation: customLocation,
        ),
      ),
    );

    print(result);
  }
}
