import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart' as sms;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'profile_screen.dart';
import 'package:get_it/get_it.dart';
import '../resources/call_and_messages.dart';
import 'dart:convert';
import 'package:sms/contact.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

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
  void getLatLong() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  void getContactDetails() async {
    UserProfile profile = await provider.getUserProfile();
    username = profile.fullName;
  }

  void getLocationDetails() async {
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
      getContactDetails();
      messageText =
          'Hey , This is $username find me at $formattedAddress .\n Link to my location : $locationUrl';
    } else {
      messageText = 'Some error ocurred';
    }
  }

  void setupLocator() {
    locator.registerSingleton(CallsAndMessagesService());
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sms
        .sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });

    print(_result);
  }

  List<String> recipents = ["8078214942"];
  UserProfileProvider provider = new UserProfileProvider();

  @override
  void initState() {
    super.initState();
    getLatLong();
    getLocationDetails();
  }

  @override
  Widget build(BuildContext context) {
    getLatLong();
    getLocationDetails();
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
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Relatives Details',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xffE3952D),
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(10),
              child: RelativeDetail(name: 'Relative 1', number: '99012932')),
          Container(
              margin: EdgeInsets.all(10),
              child: RelativeDetail(name: 'Relative 2', number: '340129355')),
          Container(
              margin: EdgeInsets.all(10),
              child: RelativeDetail(name: 'Relative 3', number: '2230156945')),
          Container(
              margin: EdgeInsets.all(10),
              child: RelativeDetail(name: 'Relative 4', number: '1901293234')),
          SizedBox(
            height: 40,
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
                              setState(() {
                                getLatLong();
                                getLocationDetails();
                              });
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
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 55.0),
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
          )
        ],
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
        Text(
          name,
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        SizedBox(
          width: 50,
        ),
        Icon(Icons.phone),
        Text(
          number,
          style: TextStyle(fontSize: 21, color: Colors.blueGrey),
        )
      ],
    );
  }
}
