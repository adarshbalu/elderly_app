import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00E676),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Image(
                image: AssetImage('lib/resources/images/logo.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Elderly Care',
              style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                'We care',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: SpinKitRipple(
                color: Colors.white,
                size: 90.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
