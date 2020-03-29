import 'dart:async';
import 'package:elderly_app/others/functions.dart';
import 'package:elderly_app/screens/home_screen.dart';
import 'package:elderly_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashHome extends StatefulWidget {
  static const String id = 'Splash_Home_Screen';
  @override
  _SplashHomeState createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
//    controller = AnimationController(
//      duration: Duration(seconds: 10),
//      lowerBound: 0,
//      upperBound: 360 * 2.0,
//      vsync: this,
//    );

    super.initState();
  }

  setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', false);
  }

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _moveDown(BuildContext context) {
    double offset = _scrollController.offset;
    _scrollController.animateTo(offset + getDeviceWidth(context),
        curve: Curves.easeIn, duration: Duration(seconds: 1));
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        finalPage = true;
      });
    }
  }

  _nextPage(BuildContext context) {
    double offset = _scrollController.offset;
    _scrollController.animateTo(offset + getDeviceWidth(context),
        curve: Curves.easeIn, duration: Duration(seconds: 1));
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        finalPage = true;
      });
    }
  }

  bool finalPage = false;
  int screen = 1;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'lib/resources/images/loadingimage.jpg',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Welcome to Elderly Care',
                      style: TextStyle(fontSize: 30, color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          _nextPage(context);
                          screen++;
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.purple,
                          child: Icon(
                            Icons.chevron_right,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.lightBlue[100]),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          _nextPage(context);
                          screen++;
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.purple,
                          child: Icon(
                            Icons.chevron_right,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          _nextPage(context);
                          screen++;
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.purple,
                          child: Icon(
                            Icons.chevron_right,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.lightBlue[100]),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          setFirstTime();
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.purple,
                          child: Icon(
                            Icons.chevron_right,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigationHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(true);
    }));
  }
}
//  void _scrollToBottom() {
//    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//        curve: Curves.easeIn, duration: Duration(seconds: 5));
//    //controller.forward();
//  }
