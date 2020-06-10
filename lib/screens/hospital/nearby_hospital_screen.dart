import 'package:elderly_app/models/hospital.dart';
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
      appBar: ElderlyAppBar(),
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
                      itemCount: snapshot.data.hospitalList.length,
                      itemBuilder: (context, index) {
                        var hosLon = snapshot
                            .data.hospitalList[index].hospitalLocationLongitude
                            .toString();
                        var hosLat = snapshot
                            .data.hospitalList[index].hospitalLocationLatitude
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
                                  child: Text(snapshot.data.hospitalList[index]
                                          .hospitalDistance
                                          .toString() +
                                      ' KM'),
                                ),
                                title: snapshot.data.hospitalList[index]
                                            .hospitalName !=
                                        null
                                    ? Text(
                                        snapshot.data.hospitalList[index]
                                            .hospitalName,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blueGrey),
                                      )
                                    : Text(''),
                                onTap: () {
                                  launch(
                                      'https://www.google.com/maps/dir/${snapshot.data.userLocation.latitude},${snapshot.data.userLocation.longitude}/$hosLat,$hosLon');
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
