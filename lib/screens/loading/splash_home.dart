import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashHome extends StatefulWidget {
  static const String id = 'Splash_Home_Screen';
  @override
  _SplashHomeState createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    var _duration = Duration(seconds: 10);
//    if (firstTime != null && !firstTime) {
//      // Not first time
//      return Timer(_duration, navigationPageHome);
//    } else {
//      // First time
//      prefs.setBool('first_time', false);
//      return Timer(_duration, navigationPageWel);
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(color: Colors.red),
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text('hello')),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(color: Colors.blue),
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text('world')),
            )
          ],
        ),
      ),
    );
  }
}
