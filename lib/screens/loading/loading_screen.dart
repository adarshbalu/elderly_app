import 'package:elderly_app/others/auth.dart';
import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:elderly_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  static const String id = 'Loading_Screen';
  LoadingScreen({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginScreen(
                auth: auth,
              );
            }
            return HomeScreen(true);
          } else {
            return Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Hero(
                      child:
                          Image.asset('lib/resources/images/loadingimage.jpg'),
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
            );
          }
        });
  }
}
