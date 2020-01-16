import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.all(90.0),
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
            Text(
              'Elderly Care',
              style: TextStyle(
                color: Colors.white,
                fontSize: 60.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xff00C853),
        ),
      ),
    );
  }
}
