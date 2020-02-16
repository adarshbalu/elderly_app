import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NearbyHospital extends StatefulWidget {
  static const String id = 'Nearby_hosptial_screen';
  @override
  _NearbyHospitalState createState() => _NearbyHospitalState();
}

class _NearbyHospitalState extends State<NearbyHospital> {
  GoogleMapController mapController;
  double latt = 1, long;
  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latt = location.lattitude;
    long = location.longitude;
    print(latt);
    print(long);
  }

  final LatLng _center = const LatLng(9.459062934746363, 76.44194636408949);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        myLocationEnabled: true,
        mapType: MapType.satellite,
      ),
    );
  }
}

class Location {
  double lattitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lattitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
