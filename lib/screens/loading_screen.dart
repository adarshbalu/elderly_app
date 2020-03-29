import 'package:elderly_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'Loading_Screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Duration duration = Duration(seconds: 3);

  Image image;
  @override
  void initState() {
    image = Image.asset('lib/resources/images/loadingimage.jpg');

    getUser().then((user) {
      Future.delayed(duration, () {
        if (user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomeScreen(true);
          }));
        } else
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
      });
    });
    Future.delayed(duration, () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen(true);
      }));
//      Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(builder: (context) => HomeScreen(true)),
//          (Route<dynamic> route) => false);
    });

    super.initState();
  }

  showSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  final _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  bool showSpinner = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

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
