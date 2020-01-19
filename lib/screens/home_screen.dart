import 'package:flutter/material.dart';
import 'package:elderly_app/others/constants.dart';

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

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: CardButton(
                      icon: Icons.assignment,
                      size: (screenWidth / 3),
                    ),
                  ),
                  Expanded(
                    child: CardButton(
                      icon: Icons.favorite,
                      size: (screenWidth / 3),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 40.0,
                          ),
                          radius: 35.0,
                        ),
                        Text(
                          'Name',
                          style: kProfileTextStyle,
                        ),
                        Text(
                          'Age',
                          style: kProfileTextStyle,
                        ),
                        Text(
                          'Gender',
                          style: kProfileTextStyle,
                        ),
                        Text(
                          'Blood Group',
                          style: kProfileTextStyle,
                        ),
                      ],
                    ),
                    width: screenWidth,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Color(0xff9765F4),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
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
  var icon, size;
  CardButton({this.icon, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff6002EE),
        borderRadius: BorderRadius.circular(5),
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
