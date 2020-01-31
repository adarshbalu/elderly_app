import 'package:flutter/material.dart';
import 'package:elderly_app/others/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        title: Text('Elderly Care'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.perm_identity,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfffcf5ee),
                    ),
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Sample Text for Application',
                      style: GoogleFonts.roboto(),
                    ),
                    height: screenHeight / 9.5,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CardButton(
                      icon: FontAwesomeIcons.heartbeat,
                      size: (screenWidth / 3),
                      color: Color(0xffD83B36),
                    ),
                  ),
                  Expanded(
                    child: CardButton(
                      icon: FontAwesomeIcons.capsules,
                      size: (screenWidth / 3),
                      color: Color(0xffE3952D),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(),
          Column(
            children: <Widget>[
              Row(),
              Row(),
            ],
          )
        ],
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  var icon, size, color;
  CardButton({this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      width: 151,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(10.0),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}

void dimensions(double a, double b) {
  print(a);
  print(b);
}
