import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Elderly '),
            Text(
              'Care',
              style: TextStyle(color: Colors.green),
            ),
            Padding(
              padding: EdgeInsets.only(right: 35),
            )
          ],
        ),
        elevation: 1,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Hero(
                      tag: 'logo',
                      child:
                          Image.asset('lib/resources/images/loadingimage.jpg')),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text('To Continue Please Sign in to the app.'),
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {
                  print('tapped');
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              SignInButtonBuilder(
                text: 'Sign in with Phone',
                icon: Icons.phone,
                onPressed: () {
                  print('tapped');
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                backgroundColor: Colors.blue[700],
              ),
              SignInButton(
                Buttons.Email,
                text: "Sign in with Email",
                onPressed: () {
                  print('tapped');
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              Padding(
                padding: EdgeInsets.all(30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
