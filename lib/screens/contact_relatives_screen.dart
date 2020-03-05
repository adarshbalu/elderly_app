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
import 'package:flutter_beautiful_popup/main.dart';

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
    String locationUrl =
        jsonDecode(data)['results'][0]['annotations']['OSM']['url'];

    String formattedAddress = jsonDecode(data)['results'][0]['formatted'];

    print(locationUrl);

    print(formattedAddress);
    getContactDetails();
    messageText =
        'Hey , This is $username find me at $formattedAddress .\n Link to my location : $locationUrl';
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

  void showWarning() async {}
  //_sendSMS(messageText, recipents);
  @override
  void initState() {
    super.initState();
    getLatLong();
  }

  @override
  Widget build(BuildContext context) {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateNotification,
    );

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
          Text('Contacting Relatives '),
          RaisedButton(
              child: Text(
                "call number",
              ),
              onPressed: () async {
                // _service.sendSms(number);

                _sendSMS(messageText, recipents);
              }),
          RaisedButton(
            child: Text(
              "send",
            ),
            onPressed: () async {
              getLatLong();
              print(latitude);
              print(longitude);
              getLocationDetails();
            },
          ),
          RaisedButton(
            child: Text('popup'),
            onPressed: () {
              popup.show(
                title: 'String or Widget',
                content: 'String or Widget',
                actions: [
                  popup.button(
                    label: 'Close',
                    onPressed: Navigator.of(context).pop,
                  ),
                ],
                // bool barrierDismissible = false,
                // Widget close,
              );
            },
          )
        ],
      ),
    );
  }
}
