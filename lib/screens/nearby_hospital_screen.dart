import 'dart:async';

import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_screen.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:http/http.dart' as http;
import 'dart:convert';

const kTomsApiKey = 'vA9uQILIGUAG86z9xCTSkETjqg7ZCiGa';
double latitude, longitude;
getLocation() async {
  LocationManager.Location location = LocationManager.Location();
  var pos = await location.getLocation();
  latitude = pos.latitude;
  longitude = pos.longitude;
  print(longitude);
  print(latitude);
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

  initState() {
    super.initState();

    getLocation();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  double lat, tempLon;
  String locationUrl;

  @override
  Widget build(BuildContext context) {
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
                  SpinKitRotatingCircle(
                    color: Colors.blue,
                    size: 100.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please wait Fetching data.'),
                  ),
                  Text(' It may take a few moments.'),
                ],
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(15),
                    color: Colors.white,
                    elevation: 2.5,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.place, color: Colors.blue),
                      ),
                      trailing: Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                      ),
                      title: snapshot.data[index].hospitalName != null
                          ? Text(
                              snapshot.data[index].hospitalName,
                            )
                          : Text(''),
                      subtitle: Text('Hospital'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => MyWebView(
                                  title: snapshot.data[index].hospitalName,
                                  selectedUrl:
                                      snapshot.data[index].hospitalLocationUrl,
                                )));
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

    print(latitude);
    print(longitude);
    http.Response response = await http.get(
        'https://api.tomtom.com/search/2/nearbySearch/.JSON?key=$kTomsApiKey&lat=$latitude&lon=$longitude&radius=5000&limit=10&categorySet=7321');
    var data = response.body;
    var status = response.statusCode;
    print(status);
    if (status == 200) {
      var jsonData = jsonDecode(data)['results'];

      for (var h in jsonData) {
        String locationUrl, placeName;
        double locationLat = h['position']['lat'];
        print(locationLat);
        double locationLon = h['position']['lon'];
        print(locationLon);
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
          Hospital hospital = Hospital(h['poi']['name'], h['position']['lat'],
              h['position']['lon'], locationUrl, placeName);
          try {
            hospitalList.add(hospital);
          } catch (e) {
            print(e);
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
  double hospitalLocationLatitude, hospitalLocationLongitude;

  Hospital(this.hospitalName, this.hospitalLocationLatitude,
      this.hospitalLocationLongitude,
      [this.hospitalLocationUrl, this.hospitalPlace]);
}

class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
