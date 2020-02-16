import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'home_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//  @override
//  initState() async {
//    super.initState();
//
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.mobile) {
//      // I am connected to a mobile network.
//    } else if (connectivityResult == ConnectivityResult.wifi) {
//      // I am connected to a wifi network.
//    }
//  }
//  final phoneNumController = TextEditingController();
//  String _smsVerificationCode;
//
//  _verifyPhoneNumber(BuildContext context) async {
//    print('Caleed');
//    String phoneNumber = "+1" + phoneNumController.text.toString();
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    await _auth.verifyPhoneNumber(
//        phoneNumber: phoneNumber,
//        timeout: Duration(seconds: 5),
//        verificationCompleted: (authCredential) =>
//            _verificationComplete(authCredential, context),
//        verificationFailed: (authException) =>
//            _verificationFailed(authException, context),
//        codeAutoRetrievalTimeout: (verificationId) =>
//            _codeAutoRetrievalTimeout(verificationId),
//        // called when the SMS code is sent
//        codeSent: (verificationId, [code]) =>
//            _smsCodeSent(verificationId, [code]));
//  }
//
//  _verificationComplete(AuthCredential authCredential, BuildContext context) {
//    FirebaseAuth.instance
//        .signInWithCredential(authCredential)
//        .then((authResult) {
//      final snackBar =
//          SnackBar(content: Text("Success!!! UUID is: " + authResult.user.uid));
//      Scaffold.of(context).showSnackBar(snackBar);
//    });
//  }
//
//  _smsCodeSent(String verificationId, List<int> code) {
//    // set the verification code so that we can use it to log the user in
//    _smsVerificationCode = verificationId;
//  }
//
//  _verificationFailed(AuthException authException, BuildContext context) {
//    final snackBar = SnackBar(
//        content:
//            Text("Exception!! message:" + authException.message.toString()));
//    Scaffold.of(context).showSnackBar(snackBar);
//  }
//
//  _codeAutoRetrievalTimeout(String verificationId) {
////    // set the verification code so that we can use it to log the user in
//    _smsVerificationCode = verificationId;
//  }
//
//  bool tap = false;

  bool login = true;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  String email, password;
  final _lauth = FirebaseAuth.instance;
  final _rauth = FirebaseAuth.instance;
  bool showSpinner = false;

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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 190,
                  padding: EdgeInsets.all(10),
                  child: Hero(
                      tag: 'logo',
                      child:
                          Image.asset('lib/resources/images/loadingimage.jpg')),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'To Continue Please Sign in to the app.',
                    textAlign: TextAlign.center,
                  ),
                ),
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
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  }
                                } catch (e) {
                                  print(e);
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
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }),
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                login
                    ? Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
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
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
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

//Column(
//children: <Widget>[
//EmailTextField(
//editingController: loginController,
//helperText: 'Enter Valid E-mail Address',
//hintText: 'Enter E-mail ',
//),
//PasswordTextField(
//editingController: loginController,
//helperText: 'Enter Minimum 6 Characters',
//hintText: 'Enter Password',
//),
//FlatButton(
//padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//color: Colors.grey.shade200,
//splashColor: Colors.white,
//child: Text(
//'Login',
//style: TextStyle(fontSize: 20),
//),
//onPressed: () {},
//),
//],
//),
