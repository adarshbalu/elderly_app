import 'package:elderly_app/screens/medicine_reminder.dart';
import 'package:elderly_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elderly_app/widgets/home_screen_widgets.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:elderly_app/screens/contact_relatives_screen.dart';
import 'package:elderly_app/others/functions.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
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
                        height: screenHeight * (20 / 100),
                        width: screenWidth * (35 / 100),
                        icon: FontAwesomeIcons.capsules,
                        size: screenWidth * 0.2,
                        color: Color(0xffE3952D),
                        borderColor: Color(0xffe2932c),
                      ),
                      onTap: () {
                        print('Medicine Tapped');
                        Navigator.pushNamed(context, MedicineReminder.id);
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
          SizedBox(
            height: screenHeight * 0.06,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: CardButton(
                        height: screenHeight * (20 / 100),
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
                        height: screenHeight * (20 / 100),
                        width: screenWidth * (35 / 100),
                        icon: FontAwesomeIcons.child,
                        size: screenWidth * (25 / 100),
                        color: Color(0xffaf5676),
                        borderColor: Color(0xffaf5676),
                      ),
                      onTap: () {
                        print('Relatives Tapped');
                        Navigator.pushNamed(context, ContactScreen.id);
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
          SizedBox(
            height: screenHeight * (5 / 100),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                print('Button urgent');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 55.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.redAccent,
                ),
                child: Text(
                  'Urgent',
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

void dimensions(double a, double b) {
  print('Height : $a');
  print('Width : $b');
}
