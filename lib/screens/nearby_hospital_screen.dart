import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker/place_picker.dart';
//import 'package:location/location.dart';
import 'dart:async';

class NearbyHospital extends StatefulWidget {
  static const String id = 'Nearby_hosptial_screen';
  @override
  _NearbyHospitalState createState() => _NearbyHospitalState();
}

class _NearbyHospitalState extends State<NearbyHospital> {
  double lat, lon;
  final Map<String, Marker> _markers = {};
//  void getLocation() async {
//    Position position = await Geolocator().getCurrentPosition();
//    double lat = position.latitude;
//    double lon = position.longitude;
//  }

//  Location location = Location();
//  LocationData locdata;
//  void getCurrLoc() async {
//    locdata = await location.getLocation();
//    print(locdata.longitude);
//  }
//
//  final CameraPosition _khos = CameraPosition(
//    target: LatLng(locdata.latitude, -122.085749655962),
//    zoom: 14.4746,
//  );

  void _getLocation() async {
    print('tap');
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }

  @override
  initState() {
    _getLocation();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    _getLocation();
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 11,
        ),
        markers: _markers.values.toSet(),
      ),

//      body: GoogleMap(
//        mapType: MapType.terrain,
//        initialCameraPosition: _kGooglePlex,
//        onMapCreated: (GoogleMapController controller) {
//          _controller.complete(controller);
//        },
//      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getLocation,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
