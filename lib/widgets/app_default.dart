import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/appoinment_reminder/appoinment_decision_screen.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/relatives/edit_relatives.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/home/home_screen.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/pages/image_label.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/medicine_reminder/medicine_decision_screen.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/notes/note_home_screen.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/loading/splash_home.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/document/view_documents_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/others/constants.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/elderly_app/lib/screens/loading/loading_screen.dart';
import 'package:flutter/services.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

final auth = FirebaseAuth.instance;
final user = FirebaseUser;
Future<FirebaseUser> getUser() async {
  return await auth.currentUser();
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen(true);
                  }));
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child:
                                  Image.asset('lib/resources/images/logo.png')),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Elderly ',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 32.0,
                            ),
                          ),
                          Text(
                            'Care',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 32.0,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ImageLabel.id);
                      },
                      splashColor: Color(0xff3c513d),
                      child: ListButtons(
                        icon: Icons.photo_camera,
                        text: 'Image Detection',
                      ),
                    ),
                    InkWell(
                      splashColor: Color(0xff3c513d),
                      onTap: () {
                        Navigator.pushNamed(context, ViewDocuments.id);
                      },
                      child: ListButtons(
                        icon: Icons.description,
                        text: 'View Documents',
                      ),
                    ),
                    InkWell(
                      splashColor: Color(0xff3c513d),
                      onTap: () {
                        Navigator.pushNamed(context, EditRelativesScreen.id);
                      },
                      child: ListButtons(
                        icon: Icons.person,
                        text: 'Edit Relatives',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SplashHome.id);
                      },
                      splashColor: Color(0xff3c513d),
                      child: ListButtons(
                        icon: Icons.create,
                        text: 'Add Notes',
                      ),
                    ),
                    InkWell(
                      splashColor: Color(0xff3c513d),
                      onTap: () {
                        print('Drawer item Tapped');
                        Navigator.pushNamed(context, NoteList.id);
                      },
                      child: ListButtons(
                        icon: Icons.list,
                        text: 'View Notes',
                      ),
                    ),
                    InkWell(
                      splashColor: Color(0xff3c513d),
                      onTap: () {
                        Navigator.pushNamed(context, AppoinmentDecision.id);
                      },
                      child: ListButtons(
                        icon: Icons.local_hospital,
                        text: 'Appoinment Decision',
                      ),
                    ),
                    InkWell(
                      splashColor: Color(0xff3c513d),
                      onTap: () {
                        Navigator.pushNamed(context, MedicineScreen.id);
                      },
                      child: ListButtons(
                        icon: Icons.alarm_on,
                        text: 'Medicine Decision',
                      ),
                    ),
                    InkWell(
                      splashColor: Color(0xff3c513d),
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RichAlertDialog(
                                alertTitle: richTitle("Log-out from the App"),
                                alertSubtitle: richSubtitle('Are you Sure '),
                                alertType: RichAlertType.WARNING,
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () async {
                                      await auth.signOut();
                                      Navigator.pushNamed(
                                          context, LoadingScreen.id);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: ListButtons(
                        icon: Icons.report,
                        text: 'Log Out',
                      ),
                    ),
                    InkWell(
                      splashColor: Color(0xff3c513d),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RichAlertDialog(
                                alertTitle: richTitle("Exit the App"),
                                alertSubtitle: richSubtitle('Are you Sure '),
                                alertType: RichAlertType.WARNING,
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: ListButtons(
                        icon: Icons.close,
                        text: 'Exit App',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Text('Application in Development'),
                  margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListButtons extends StatelessWidget {
  String text;
  var icon;
  ListButtons({this.text, this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: kDrawerListStyle,
      ),
      leading: Icon(
        icon,
        color: Color(0xff3c513d),
        size: 37.0,
      ),
    );
  }
}

class FormItem extends StatelessWidget {
  final String hintText;
  final String helperText;
  Function onChanged;
  final bool isNumber;
  IconData icon;
  final controller;

  FormItem(
      {this.hintText,
      this.helperText,
      this.onChanged,
      this.icon,
      this.isNumber: false,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(5),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
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
        onChanged: (String value) {
          onChanged(value);
        },
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
