import 'package:elderly_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'Loading_Screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Duration duration = Duration(seconds: 3);

  @override
  void initState() {
    getUser().then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    });

    Future.delayed(duration, () {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });

    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: WillPopScope(
        onWillPop: () async {
          return await Future.value(false);
        },
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Hero(
                child: Image.asset('lib/resources/images/loadingimage.jpg'),
                tag: 'logo',
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Some Catchy Slogan for the app',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
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
      ),
    );
  }
}
