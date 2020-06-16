import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'OnBoarding_screen';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    startTime();
    initPrefs();
    super.initState();
  }

  SharedPreferences prefs;
  bool showOnBoarding = false;
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    showOnBoarding = prefs.getBool('first') ?? true;
  }

  startTime() async {
    var _duration = Duration(seconds: 10);
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
              child: Center(
                  child: InkWell(
                      onTap: () async {
                        await prefs.setBool('first', false);
                      },
                      child: Text('world'))),
            )
          ],
        ),
      ),
    );
  }
}
