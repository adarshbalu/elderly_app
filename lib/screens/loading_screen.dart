import 'package:elderly_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'Loading_Screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Duration duration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    Future.delayed(duration, () {
      Navigator.pushNamed(context, HomeScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Image.asset('lib/resources/images/loadingimage.jpg'),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Elderly ',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  'Care',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SpinKitFadingCube(
              color: Colors.greenAccent,
              size: 50.0,
            ),
          )
        ],
      ),
    );
  }
}
