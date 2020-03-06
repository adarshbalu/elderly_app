import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';

const kGoogleApiKey = 'AIzaSyBRSjFpkj9vWq4ETzy-mG5fCmhleGPdmnY';

class NearbyHospitalScreen extends StatefulWidget {
  static const String id = 'Nearby_Hospital_screen';
  @override
  State<StatefulWidget> createState() {
    return NearbyHospitalScreenState();
  }
}

class NearbyHospitalScreenState extends State<NearbyHospitalScreen> {
  MapController mapController;
  GoogleMapController googleMapController;

  double latitude, longitude;
  getLocation() async {
    LocationManager.Location location = LocationManager.Location();
    var pos = await location.getLocation();
    latitude = pos.latitude;
    longitude = pos.longitude;
    print(longitude);
    print(latitude);
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
        body: GoogleMap(
      onMapCreated: (GoogleMapController googleMapController) {
        this.googleMapController = googleMapController;
      },
      mapType: MapType.satellite,
      initialCameraPosition:
          CameraPosition(target: LatLng(0.1, 020), zoom: 11.0),
    ));
  }
}
