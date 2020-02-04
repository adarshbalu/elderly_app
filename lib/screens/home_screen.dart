import 'package:flutter/material.dart';
import 'package:elderly_app/others/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elderly_app/widgets/home_screen_widgets.dart';
import 'package:elderly_app/widgets/app_default.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double screenWidth = deviceInfo.size.width;
    double screenHeight = deviceInfo.size.height;
    dimensions(screenHeight, screenWidth);

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
            height: screenHeight * (9 / 100),
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
          SizedBox(
            height: 30.0,
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
          Center(
            child: GestureDetector(
              onTap: () {
                print('Urgent Tapped');
              },
              child: Container(
                height: screenHeight * (10 / 100),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red[200],
                      blurRadius: 10.0,
                      offset: Offset(0, 8.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Text(
                  'Urgent',
                  style: TextStyle(
                    color: Colors.white, //837666
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void dimensions(double a, double b) {
  print(a);
  print(b);
}
