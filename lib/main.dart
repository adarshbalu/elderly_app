import 'package:elderly_app/screens/home_screen.dart';
import 'package:elderly_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/screens/profile_screen.dart';

void main() => runApp(ElderlyApp());

class ElderlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elderly Care',
      initialRoute: LoadingScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
      },
      theme: ThemeData(
        fontFamily: 'OpenSans',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        textTheme: TextTheme(
            display1: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        )),
      ),
    );
  }
}
