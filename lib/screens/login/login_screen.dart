import 'package:auto_size_text/auto_size_text.dart';
import 'package:elderly_app/others/auth.dart';
import 'package:elderly_app/others/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';
  LoginScreen({@required this.auth});
  final AuthBase auth;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _signInWithGoogle() async {
    try {
      await widget.auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Hero(
              child: Image.asset('lib/resources/images/loadingimage.jpg'),
              tag: 'logo',
            ),
          ),
          Card(
            elevation: 3,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Continue to Elderly Care',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter email-address',
                        prefixIcon: Icon(Icons.email, color: Colors.indigo),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo,
                                style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue, style: BorderStyle.solid)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      controller: passwordController,
                      style: TextStyle(),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo,
                                style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue, style: BorderStyle.solid)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade300,
                    padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                    onPressed: () {},
                    label: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: AutoSizeText(
                          'Don\'t have an account? ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: AutoSizeText('Sign up',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        kFacebookImage,
                        height: 55,
                      ),
                      SizedBox(
                        width: 28,
                      ),
                      GestureDetector(
                        onTap: _signInWithGoogle,
                        child: Image.asset(
                          kGoogleImage,
                          height: 55,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
