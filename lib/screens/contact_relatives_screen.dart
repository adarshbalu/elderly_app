import 'package:elderly_app/others/constants.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/home_screen_widgets.dart';
import 'profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import '../resources/call_and_messages.dart';
import '../resources/service_locator.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactScreen extends StatefulWidget {
  static const String id = 'Contact_Screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  GetIt locator = GetIt.instance;

  void setupLocator() {
    locator.registerSingleton(CallsAndMessagesService());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double screenWidth = deviceInfo.size.width;
    double screenHeight = deviceInfo.size.height;
    final String number = '8078214942';
    final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
    return Scaffold(
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
              "call $number",
            ),
            onPressed: () async {
              Map<PermissionGroup, PermissionStatus> permissions =
                  await PermissionHandler()
                      .requestPermissions([PermissionGroup.contacts]);
              PermissionStatus permission = await PermissionHandler()
                  .checkPermissionStatus(PermissionGroup.location);

              bool isShown = await PermissionHandler()
                  .shouldShowRequestPermissionRationale(
                      PermissionGroup.location);
              _service.sendSms(number);
            },
          ),
        ],
      ),
    );
  }
}
