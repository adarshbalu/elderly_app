import 'package:elderly_app/others/auth.dart';
import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:elderly_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elderly_app/screens/loading/onBoarding_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'Loading_Screen';
  LoadingScreen({@required this.auth});
  final AuthBase auth;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Image myImage;
  SharedPreferences prefs;
  bool showOnBoarding = false;
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    showOnBoarding = prefs.getBool('first') ?? true;
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
    myImage = Image.asset('lib/resources/images/loadingimage.jpg');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: widget.auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginScreen(
                auth: widget.auth,
              );
            }
            if (showOnBoarding) {
              return OnBoardingScreen();
            }
            return HomeScreen();
          } else {
            return Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: myImage,
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
                        'Care is a click away',
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
            );
          }
        });
  }
}
