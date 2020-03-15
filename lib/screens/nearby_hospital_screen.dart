import 'dart:async';

import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_screen.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

const kTomsApiKey = 'vA9uQILIGUAG86z9xCTSkETjqg7ZCiGa';
double latitude, longitude;
LocationManager.Location location = LocationManager.Location();
Geolocator _geolocator = Geolocator();
getLocation() async {
  var a = await _geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  latitude = a.latitude;
  longitude = a.longitude;
  //var pos = await location.getLocation();
  //latitude = pos.latitude;
  //longitude = pos.longitude;
}

class NearbyHospitalScreen extends StatefulWidget {
  static const String id = 'Nearby_Hospital_screen';
  @override
  State<StatefulWidget> createState() {
    return NearbyHospitalScreenState();
  }
}

class NearbyHospitalScreenState extends State<NearbyHospitalScreen> {
  bool showSpinner = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    getLocation();
    super.initState();
  }

  double lat, tempLon;
  String locationUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          await getLocation();
          await getNearbyHospitals();
        },
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Elderly '),
            Text(
              'Care',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              print('Profile Button Tapped');
              Navigator.pushNamed(context, ProfileScreen.id);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.perm_identity,
                size: 30,
                color: Color(0xff5e444d),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getNearbyHospitals(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitWanderingCubes(
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fetching data . Please wait ..'),
                  ),
                  Text(' It may take a few moments .'),
                ],
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  getLocation();
                  var hosLon =
                      snapshot.data[index].hospitalLocationLongitude.toString();
                  var hosLat =
                      snapshot.data[index].hospitalLocationLatitude.toString();
                  return Card(
                    margin: EdgeInsets.all(15),
                    color: Colors.white,
                    elevation: 2.5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.local_hospital,
                            size: 40, color: Colors.red),
                      ),
                      subtitle: Text(
                          snapshot.data[index].hospitalDistance.toString() +
                              ' KM'),
                      title: snapshot.data[index].hospitalName != null
                          ? Text(
                              snapshot.data[index].hospitalName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blueGrey),
                            )
                          : Text(''),
                      onTap: () {
//
                        launch(
                            'https://www.google.com/maps/dir/$latitude,$longitude/$hosLat,$hosLon');
                      },
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  Future<List<Hospital>> getNearbyHospitals() async {
    List<Hospital> hospitalList = [];

    await getLocation();
//    setState(() {
//      location
//          .onLocationChanged()
//          .listen((LocationManager.LocationData currentLocation) {
//        longitude = currentLocation.longitude;
//        latitude = currentLocation.latitude;
//      });
//    });
    print('Latitude : ' + latitude.toString());
    print('Longitude : ' + longitude.toString());
    http.Response response = await http.get(
        'https://api.tomtom.com/search/2/nearbySearch/.JSON?key=$kTomsApiKey&lat=$latitude&lon=$longitude&radius=3000&limit=20&categorySet=7321');
    var data = response.body;
    var status = response.statusCode;
    print('Hospital Search Status : ' + status.toString());
    if (status == 200) {
      var jsonData = jsonDecode(data)['results'];
      for (var h in jsonData) {
        String locationUrl, placeName;
        double locationLat = h['position']['lat'];
        print('Hospital Latitude : ' + locationLat.toString());
        double locationLon = h['position']['lon'];
        print('Hospital Longitude : ' + locationLon.toString());

        http.Response urlResponse = await http.get(
            'https://api.opencagedata.com/geocode/v1/json?q=$locationLat+$locationLon&key=f29cf18b10224e27b8931981380b747a');
        String urlData = urlResponse.body;
        var urlJson = jsonDecode(urlData)['results'][0];
        var urlStatus = urlResponse.statusCode;
        print(urlStatus);
        if (urlStatus == 200) {
          print(h['poi']['name']);
          locationUrl = urlJson['annotations']['OSM']['url'];
          placeName = urlJson['components']['town'];
          print(locationUrl);
          http.Response distanceResponse = await http.get(
              'https://api.tomtom.com/routing/1/calculateRoute/$latitude,$longitude:$locationLat,$locationLon/json?key=G5IOmgbhnBgevPJeglEK2zGJyYv6TG1Z');
          var distanceStatus = distanceResponse.statusCode;
          if (distanceStatus == 200) {
            var distanceData = distanceResponse.body;

            double hospitalDistance = jsonDecode(distanceData)['routes'][0]
                    ['summary']['lengthInMeters'] /
                1000;
            print(hospitalDistance);

            Hospital hospital = Hospital(h['poi']['name'], h['position']['lat'],
                h['position']['lon'], locationUrl, placeName, hospitalDistance);
            try {
              hospitalList.add(hospital);
            } catch (e) {
              print(e);
            }
          }
        }
      }
      print(hospitalList.length);
      return hospitalList;
    } else {
      return [];
    }
  }
}

class Hospital {
  String hospitalName, hospitalLocationUrl, hospitalPlace;
  double hospitalLocationLatitude, hospitalLocationLongitude, hospitalDistance;

  Hospital(this.hospitalName, this.hospitalLocationLatitude,
      this.hospitalLocationLongitude,
      [this.hospitalLocationUrl, this.hospitalPlace, this.hospitalDistance]);
}
