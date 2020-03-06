import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_screen.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:http/http.dart' as http;
import 'dart:convert';

const kTomsApiKey = 'vA9uQILIGUAG86z9xCTSkETjqg7ZCiGa';

class NearbyHospitalScreen extends StatefulWidget {
  static const String id = 'Nearby_Hospital_screen';
  @override
  State<StatefulWidget> createState() {
    return NearbyHospitalScreenState();
  }
}

class NearbyHospitalScreenState extends State<NearbyHospitalScreen> {
  double latitude, longitude;
  bool showSpinner = true;
  getLocation() async {
    LocationManager.Location location = LocationManager.Location();
    var pos = await location.getLocation();
    latitude = pos.latitude;
    longitude = pos.longitude;
    print(longitude);
    print(latitude);
  }

  initState() {
    super.initState();
    getLocation();
    getNearbyHospitals();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  changeScreen() async {
    Future.delayed(Duration(seconds: 10));
    setState(() {
      showSpinner = false;
    });
  }

  //https://api.tomtom.com/search/2/nearbySearch/.JSON?key=vA9uQILIGUAG86z9xCTSkETjqg7ZCiGa&lat=11.5924988&lon=75.5976548&radius=1000&categorySet=7321
  List<String> hospitalName = [''];

  List<double> hospitalLat = [];
  List<double> hospitalLongitude = [];
  double lat, tempLon;
  String locationUrl;
  void getNearbyHospitals() async {
    http.Response response = await http.get(
        'https://api.tomtom.com/search/2/nearbySearch/.JSON?key=$kTomsApiKey&lat=$latitude&lon=$longitude&radius=5000&limit=10&categorySet=7321');
    String data = response.body;
    var status = response.statusCode;
    if (status == 200) {
      for (int i = 0; i < 10; i++) {
        hospitalName.insert(
            i, jsonDecode(data)['results'][i]['poi']['name'].toString());
      }
      for (int i = 0; i < 10; i++) {
        tempLon = jsonDecode(data)['results'][i]['position']['lon'];

        hospitalLongitude.insert(i, tempLon);

        hospitalLat.insert(
            i, jsonDecode(data)['results'][i]['position']['lat']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    getNearbyHospitals();
    changeScreen();

    return Scaffold(
        drawer: AppDrawer(),
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
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView(
            children: <Widget>[
              ListCard(
                getUrl: getUrl(0),
                position: 0,
                hospitalName: hospitalName,
              ),
            ],
          ),
        ));
  }

  getUrl(int position) async {
    double locationLat = hospitalLat[position];
    double locationLon = hospitalLongitude[position];
    http.Response response = await http.get(
        'https://api.opencagedata.com/geocode/v1/json?q=$locationLat+$locationLon&key=f29cf18b10224e27b8931981380b747a');
    String data = response.body;
    var status = response.statusCode;
    if (status == 200) {
      locationUrl = jsonDecode(data)['results'][0]['annotations']['OSM']['url'];
      print(locationUrl);
    }
  }

  Widget getListView() {
    return FutureBuilder(builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            margin: EdgeInsets.all(15),
            color: Colors.white,
            elevation: 2.5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.place, color: Colors.red),
              ),
              title: Text(
                this.hospitalName[position],
                //style: titleStyle,
              ),
              onTap: () async {
                await getUrl(position);
                await _launchURL(locationUrl);
              },
            ),
          );
        },
      );
    });
  }
}

class ListCard extends StatelessWidget {
  var position, hospitalName, getUrl;
  ListCard({this.position, this.hospitalName, this.getUrl});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      color: Colors.white,
      elevation: 2.5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.place, color: Colors.red),
        ),
        title: Text(
          this.hospitalName[position],
          //style: titleStyle,
        ),
        onTap: () {
          getUrl(position);
        },
      ),
    );
  }
}
