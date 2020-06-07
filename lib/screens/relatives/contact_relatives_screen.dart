import 'package:elderly_app/models/elder_location.dart';
import 'package:elderly_app/models/location.dart';
import 'package:elderly_app/models/user.dart';
import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactScreen extends StatefulWidget {
  static const String id = 'Contact_Screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  UserLocation location;
  ElderLocation elderLocation;
  String messageText = '', username = 'user', userId;
  bool relativesFound = false;

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  getLocationDetails() async {
    await elderLocation.getLocationData(location);
    messageText =
        'Hey , This is $username find me at ${elderLocation.address} .\n Link to my location : ${elderLocation.url}';
    return elderLocation;
  }

  _sendSMS(String message, List<String> recipients) async {
    String _result = await sendSMS(message: message, recipients: recipients)
        .catchError((onError) {
      print(onError);
    });

    print(_result);
  }

  List<String> recipients = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    elderLocation = ElderLocation();
    location = UserLocation(longitude: 0, latitude: 0);
    location.getLocation();

    getLocationDetails();
  }

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
        body: ListView(
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance
                    .collection('profile')
                    .document(userId)
                    .collection('relatives')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> relativesWidget = List();
                    var data = snapshot.data.documents;
                    if (data != null) {
                      relativesFound = true;
                      UserProfile userProfile = UserProfile(userId);
                      userProfile.getAllRelatives(data);
                      for (var relative in userProfile.relatives) {
                        recipients.add(relative.phoneNumber);
                        relativesWidget.add(RelativeDetail(
                          name: relative.name,
                          email: relative.email,
                          number: relative.phoneNumber,
                        ));
                      }
                      relativesWidget.add(SizedBox(
                        height: 10,
                      ));
                    } else {
                      relativesFound = false;
                      relativesWidget.add(Center(
                        child: Container(
                          decoration: BoxDecoration(),
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                child: Text('No relatives added.'),
                              ),
                              RaisedButton(
                                  onPressed: () {},
                                  color: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'Add Relatives',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        ),
                      ));
                    }

                    return Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Text(
                              'Relatives Details',
                              style: TextStyle(
                                fontSize: 32,
                                color: Color(0xffE3952D),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: relativesWidget,
                        ),
                      ],
                    );
                  } else
                    return Container(
                      child: SpinKitWanderingCubes(
                        color: Colors.green,
                        size: 100.0,
                      ),
                    );
                }),
            FutureBuilder(
                future: getLocationDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && relativesFound) {
                    ElderLocation _elderLocation = snapshot.data;
                    if (_elderLocation == null) return SizedBox();
                    return Center(
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
                                        Navigator.pop(context);
                                        _sendSMS(messageText, recipients);
                                        print(messageText);
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    );
                  } else
                    return LinearProgressIndicator();
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}

class RelativeDetail extends StatelessWidget {
  final String name;
  final String number;
  final String email;

  RelativeDetail({this.name, this.number, this.email});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon(
          Icons.person_pin,
          size: 45,
          color: Colors.blue,
        ),
        contentPadding: EdgeInsets.all(8),
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(name),
        ),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Number : '),
                Expanded(child: Text(number)),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Email : '),
                Expanded(child: Text(email))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
