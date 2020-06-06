import 'package:elderly_app/models/elder_location.dart';
import 'package:elderly_app/models/location.dart';
import 'package:elderly_app/models/user.dart';
import 'package:elderly_app/others/constants.dart';
import 'package:elderly_app/resources/call_and_messages.dart';
import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:elderly_app/screens/relatives/edit_relatives.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_sms/flutter_sms.dart' as sms;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
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
  UserLocation location = UserLocation();
  ElderLocation elderLocation = ElderLocation();
  String messageText = '';
  String username = 'user';
  FirebaseUser loggedInUser;

  String userId;
  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  getLocationDetails() async {
    await location.getLocation();
    String url =
        'https://api.opencagedata.com/geocode/v1/json?q=${location.latitude}+${location.longitude}&key=$kOpenCageApiKey';
    await elderLocation.getLocationData(url);
    setState(() {
      messageText =
          'Hey , This is $username find me at ${elderLocation.address} .\n Link to my location : ${elderLocation.url}';
    });
  }

  setupLocator() {
    locator.registerSingleton(CallsAndMessagesService());
  }

  _sendSMS(String message, List<String> recipients) async {
    await getLocationDetails();

//    String _result = await sms
//        .sendSMS(message: message, recipients: recipents)
//        .catchError((onError) {
//      print(onError);
//    });

//    print(_result);
  }

  List<String> recipients = [];
//  UserProfileProvider provider = new UserProfileProvider();

  @override
  void initState() {
    location.getLocation();
    getLocationDetails();
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('profile')
                .document(userId)
                .collection('relatives')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> relativesWidget = List();
                var data = snapshot.data.documents;
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
                return ListView(
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
                                        await getLocationDetails();

                                        Navigator.pop(context);
//                                        _sendSMS(messageText, recipients);
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, EditRelativesScreen.id);
                        },
                      ),
                    )
                  ],
                );
              } else
                return Container(
                  child: SpinKitWanderingCubes(
                    color: Colors.green,
                    size: 100.0,
                  ),
                );
            }));
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
                Text('Phone Number : '),
                Text(number)
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
                Text('Email Address : '),
                Text(email)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
