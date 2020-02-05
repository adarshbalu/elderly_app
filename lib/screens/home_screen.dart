import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elderly_app/widgets/home_screen_widgets.dart';
import 'package:elderly_app/widgets/app_default.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double factor = 0;
    double screenWidth = deviceInfo.size.width;
    double screenHeight = deviceInfo.size.height;
    dimensions(screenHeight, screenWidth);
    if (screenHeight > 640) {
      factor = screenHeight * (5 / 100);
    }
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Elderly Care'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: screenHeight * (9 / 100),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: CardButton(
                          height: screenHeight * (20 / 100) - factor,
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
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Check your Heartbeat'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: CardButton(
                          height: screenHeight * (20 / 100) - factor,
                          width: screenWidth * (35 / 100),
                          icon: FontAwesomeIcons.capsules,
                          size: screenWidth * (25 / 100),
                          color: Color(0xffE3952D),
                          borderColor: Color(0xffe2932c),
                        ),
                        onTap: () {
                          print('Medicine Tapped');
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Add Medicine Reminder'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * (7.5 / 100) - factor,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: CardButton(
                          height: screenHeight * (20 / 100) - factor,
                          width: screenWidth * (35 / 100),
                          icon: FontAwesomeIcons.hospital,
                          size: screenWidth * (25 / 100),
                          color: Color(0xff3c513d),
                          borderColor: Color(0xff3c513d),
                        ),
                        onTap: () {
                          print('Hospital Tapped');
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Locate Nearby Hospital'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: CardButton(
                          height: screenHeight * (20 / 100) - factor,
                          width: screenWidth * (35 / 100),
                          icon: FontAwesomeIcons.child,
                          size: screenWidth * (25 / 100),
                          color: Color(0xffaf5676),
                          borderColor: Color(0xffaf5676),
                        ),
                        onTap: () {
                          print('Relatives Tapped');
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Contact Relatives'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * (5 / 100) - factor,
          ),
          Expanded(
            child: RaisedButton(
              child: Text('Button'),
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),
          )
        ],
      ),
    );
  }
}

void dimensions(double a, double b) {
  print('Height : $a');
  print('Width : $b');
}
