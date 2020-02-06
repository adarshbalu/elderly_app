import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/home_screen_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactScreen extends StatefulWidget {
  static const String id = 'Contact_Screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double screenWidth = deviceInfo.size.width;
    double screenHeight = deviceInfo.size.height;

    return Scaffold(
      body: Container(
        child: GridView(
          children: <Widget>[
            GestureDetector(
              child: CardButton(
                height: screenHeight * 0.2,
                width: screenWidth * (35 / 100),
                icon: FontAwesomeIcons.heartbeat,
                size: screenWidth * (25 / 100),
                color: Color(0xffD83B36),
                borderColor: Color(0xffd93b36),
              ),
              onTap: () {
                print('Heartbeat Tapped');
              },
            ),
            GestureDetector(
              child: CardButton(
                height: screenHeight * 0.2,
                width: screenWidth * (35 / 100),
                icon: FontAwesomeIcons.hospital,
                size: screenWidth * (25 / 100),
                color: Color(0xffD83B36),
                borderColor: Color(0xffd93b36),
              ),
              onTap: () {
                print('Heartbeat Tapped');
              },
            ),
          ],
        ),
      ),
    );
  }
}
