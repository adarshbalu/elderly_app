import 'package:elderly_app/screens/initial_setup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'home_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    getUser().then((user) {
      if (user != null) {
        setState(() {
          showSpinner = !showSpinner;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen(true);
        }));
      }
    });
    super.initState();
  }

  Future<FirebaseUser> getUser() async {
    return await _lauth.currentUser();
  }

  bool login = true;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  String email, password;
  final _lauth = FirebaseAuth.instance;
  final _rauth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
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
      body: WillPopScope(
        onWillPop: () async {
          return await Future.value(false);
        },
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: Center(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 170,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                            'lib/resources/images/loadingimage.jpg')),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      'To Continue Please Sign in to the app.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                      child: login
                          ? Container(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.green),
                              ),
                            )
                          : Container(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.greenAccent),
                              ),
                            )),
                  login
                      ? Column(
                          children: <Widget>[
                            EmailTextField(
                              editingController: emailController,
                              helperText: 'Enter Valid E-mail Address',
                              hintText: 'Enter E-mail ',
                              emailGetter: (value) {
                                email = value;
                              },
                            ),
                            PasswordTextField(
                              editingController: passwordController,
                              helperText: 'Enter Minimum 6 Characters',
                              hintText: 'Enter Password',
                              passwordGetter: (value) {
                                password = value;
                              },
                            ),
                            FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                color: Colors.grey.shade200,
                                splashColor: Colors.white,
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = !showSpinner;
                                  });
                                  try {
                                    final newUser =
                                        await _lauth.signInWithEmailAndPassword(
                                            email: email, password: password);
                                    if (newUser != null) {
                                      setState(() {
                                        showSpinner = !showSpinner;
                                      });
                                      Navigator.pushNamed(
                                          context, HomeScreen.id);
                                    } else {
                                      setState(() {
                                        showSpinner = !showSpinner;
                                      });
                                    }
                                  } catch (e) {
                                    setState(() {
                                      showSpinner = !showSpinner;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return RichAlertDialog(
                                            alertTitle:
                                                richTitle("An Error Occured"),
                                            alertSubtitle:
                                                richSubtitle(e.toString()),
                                            alertType: RichAlertType.ERROR,
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                }),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            EmailTextField(
                              editingController: emailController,
                              helperText: 'Enter Valid E-mail Address',
                              hintText: 'Enter E-mail ',
                              emailGetter: (value) {
                                email = value;
                              },
                            ),
                            PasswordTextField(
                              editingController: passwordController,
                              helperText: 'Enter Minimum 6 Characters',
                              hintText: 'Enter Password',
                              passwordGetter: (value) {
                                password = value;
                              },
                            ),
                            FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                color: Colors.grey.shade200,
                                splashColor: Colors.white,
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = !showSpinner;
                                  });
                                  try {
                                    final user = await _rauth
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password);
                                    if (user != null) {
                                      setState(() {
                                        showSpinner = !showSpinner;
                                      });
                                      Navigator.pushNamed(
                                          context, InitialSetupScreen.id);
                                    } else {
                                      setState(() {
                                        showSpinner = !showSpinner;
                                      });
                                    }
                                  } catch (e) {
                                    setState(() {
                                      showSpinner = !showSpinner;
                                    });

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return RichAlertDialog(
                                            alertTitle:
                                                richTitle("An Error Occured"),
                                            alertSubtitle:
                                                richSubtitle(e.toString()),
                                            alertType: RichAlertType.ERROR,
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                }),
                          ],
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  login
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: SignInButtonBuilder(
                            text: 'Register to ElderlyCare',
                            icon: Icons.person_add,
                            onPressed: () {
                              setState(() {
                                login = !login;
                              });
                            },
                            backgroundColor: Colors.blueGrey[700],
                          ),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: SignInButtonBuilder(
                            text: 'Login to ElderlyCare',
                            icon: Icons.person,
                            onPressed: () {
                              setState(() {
                                login = !login;
                              });
                            },
                            backgroundColor: Colors.blueGrey[700],
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  var editingController = TextEditingController();
  final String helperText;
  final String hintText;
  Function passwordGetter;

  PasswordTextField(
      {this.editingController,
      this.passwordGetter,
      this.helperText,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        obscureText: true,
        controller: editingController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Colors.indigo, style: BorderStyle.solid)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
          hintText: hintText,
          helperText: helperText,
          icon: Icon(Icons.lock, color: Colors.blueAccent),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
        ),
        onChanged: passwordGetter,
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  var editingController = TextEditingController();
  final String helperText;
  final String hintText;
  Function emailGetter;

  EmailTextField(
      {this.editingController,
      this.emailGetter,
      this.helperText,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: editingController,
        style: TextStyle(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
          helperText: helperText,
          icon: Icon(Icons.email, color: Colors.blueAccent),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Colors.indigo, style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
        ),
        onChanged: emailGetter,
      ),
    );
  }
}
