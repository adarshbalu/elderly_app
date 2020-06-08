import 'package:elderly_app/models/hospital.dart';
import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as LocationManager;

LocationManager.Location location = LocationManager.Location();

class NearbyHospitalScreen extends StatefulWidget {
  static const String id = 'Nearby_Hospital_screen';
  @override
  State<StatefulWidget> createState() {
    return NearbyHospitalScreenState();
  }
}

class NearbyHospitalScreenState extends State<NearbyHospitalScreen> {
  bool showSpinner = true;
  HospitalData hospitalData;
  @override
  initState() {
    super.initState();
    hospitalData = HospitalData();
    hospitalData.getNearbyHospital();
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
          await hospitalData.getNearbyHospital();
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
        future: hospitalData.getNearbyHospital(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitChasingDots(
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
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Nearby Hospitals',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: hospitalData.hospitalList.length,
                      itemBuilder: (context, index) {
                        var hosLon = hospitalData
                            .hospitalList[index].hospitalLocationLongitude
                            .toString();
                        var hosLat = hospitalData
                            .hospitalList[index].hospitalLocationLatitude
                            .toString();

                        return Column(
                          children: <Widget>[
                            Card(
                              margin: EdgeInsets.all(15),
                              color: Colors.white,
                              elevation: 2.5,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(Icons.local_hospital,
                                      size: 40, color: Colors.red),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(hospitalData
                                          .hospitalList[index].hospitalDistance
                                          .toString() +
                                      ' KM'),
                                ),
                                title: hospitalData
                                            .hospitalList[index].hospitalName !=
                                        null
                                    ? Text(
                                        hospitalData
                                            .hospitalList[index].hospitalName,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blueGrey),
                                      )
                                    : Text(''),
                                onTap: () {
                                  launch(
                                      'https://www.google.com/maps/dir/${hospitalData.userLocation.latitude},${hospitalData.userLocation.longitude}/$hosLat,$hosLon');
                                },
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
