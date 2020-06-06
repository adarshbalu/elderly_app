import 'package:elderly_app/resources/call_and_messages.dart';
import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:elderly_app/screens/relatives/edit_relatives.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_sms/flutter_sms.dart' as sms;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'dart:convert';
//import 'package:sms/contact.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactScreen extends StatefulWidget {
  static const String id = 'Contact_Screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  GetIt locator = GetIt.instance;

  double latitude, longitude;
  String messageText = '';
  String username = 'user';
  String relative1name, relative2name, relative1num, relative2num;
  int load = 0;
  FirebaseUser loggedInUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String userId;
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      loggedInUser = user;
      userId = loggedInUser.uid;
      print(userId);
      await getUserRelatives();

//      if (loggedInUser.displayName != null) {
//        username = loggedInUser.displayName.toString();
//      }
    } catch (e) {
      print(e);
    }
  }

  final fireStoreDatabase = Firestore.instance;
  Future getUserRelatives() async {
    await fireStoreDatabase
        .collection('profile')
        .document(userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      print(snapshot.data);
      if (mounted)
        setState(() {
          relative2name = snapshot.data['relative2name'];
          relative1name = snapshot.data['relative1name'];
          relative2num = snapshot.data['relative2number'];
          relative1num = snapshot.data['relative1number'];
          username = snapshot.data['userName'];
          recipents.add(relative1num);
          recipents.add(relative2num);
          load++;
        });
    });
  }

  getLatLong() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  Future waitForLocation() async {
    await getLatLong();
  }

  getLocationDetails() async {
    await getLatLong();

    http.Response response = await http.get(
        'https://api.opencagedata.com/geocode/v1/json?q=$latitude+$longitude&key=f29cf18b10224e27b8931981380b747a');
    String data = response.body;
    var status = response.statusCode;
    if (status == 200) {
      String locationUrl =
          jsonDecode(data)['results'][0]['annotations']['OSM']['url'];

      String formattedAddress = jsonDecode(data)['results'][0]['formatted'];

      print(locationUrl);

      print(formattedAddress);

      getLatLong();

      messageText =
          'Hey , This is $username find me at $formattedAddress .\n Link to my location : $locationUrl';
    } else {
      messageText = 'Some error ocurred';
    }
  }

  setupLocator() {
    locator.registerSingleton(CallsAndMessagesService());
  }

  _sendSMS(String message, List<String> recipents) async {
    await getLocationDetails();

//    String _result = await sms
//        .sendSMS(message: message, recipients: recipents)
//        .catchError((onError) {
//      print(onError);
//    });

//    print(_result);
  }

  List<String> recipents = [];
//  UserProfileProvider provider = new UserProfileProvider();

  @override
  void initState() {
    getLatLong();
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (load < 2) {
      getCurrentUser();
      getLatLong();
      getLocationDetails();
    }
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double screenWidth = deviceInfo.size.width;
    double screenHeight = deviceInfo.size.height;
    final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
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
      body: load > 2
          ? ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Text(
                      'Relatives Details',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xffE3952D),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: RelativeDetail(
                        name: relative1name, number: relative1num)),
                Container(
                    margin: EdgeInsets.all(10),
                    child: RelativeDetail(
                        name: relative2name, number: relative2num)),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RichAlertDialog(
                              alertTitle: richTitle("Alert Relatives"),
                              alertSubtitle: richSubtitle('Are you Sure '),
                              alertType: RichAlertType.INFO,
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    getLatLong();
                                    getLocationDetails();

                                    Navigator.pop(context);
                                    _sendSMS(messageText, recipents);
                                  },
                                ),
                                FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 55.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.redAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 3.0,
                            offset: Offset(0, 4.0),
                          ),
                        ],
                      ),
                      child: Text(
                        'Contact Relatives',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 55.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepPurple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple,
                            blurRadius: 3.0,
                            offset: Offset(0, 4.0),
                          ),
                        ],
                      ),
                      child: Text(
                        'Edit Relatives',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, EditRelativesScreen.id);
                    },
                  ),
                )
              ],
            )
          : Container(
              child: SpinKitWanderingCubes(
                color: Colors.green,
                size: 100.0,
              ),
            ),
    );
  }
}

class RelativeDetail extends StatelessWidget {
  String name;
  String number;

  RelativeDetail({this.name, this.number});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.person_pin_circle),
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(Icons.phone),
        Expanded(
          child: Text(
            number,
            style: TextStyle(fontSize: 21, color: Colors.blueGrey),
          ),
        )
      ],
    );
  }
}
