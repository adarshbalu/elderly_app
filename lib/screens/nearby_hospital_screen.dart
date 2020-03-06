import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as LocationManager;
//import 'place_detail.dart';
import 'dart:convert';
import 'package:google_maps_webservice/directions.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
