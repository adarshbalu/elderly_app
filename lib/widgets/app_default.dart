import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:elderly_app/screens/loading/loading_screen.dart';
import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:elderly_app/screens/relatives/link_relative.dart';

final auth = FirebaseAuth.instance;
final user = FirebaseUser;
Future<FirebaseUser> getUser() async {
  return await auth.currentUser();
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Drawer(
        elevation: 1,
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        DrawerHeader(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: Divider.createBorderSide(context,
                                      color: Colors.transparent, width: 0))),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Image.asset(
                                        'lib/resources/images/logo.png')),
                                SizedBox(
                                  width: 20,
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
                              ],
                            ),
                          ),
                        ),
                        ListButtons(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LinkRelative();
                            }));
                          },
                          icon: Icons.person_add,
                          text: 'Link Relative',
                        ),
                        ListButtons(
                          onTap: () {},
                          icon: Icons.description,
                          text: 'Instructions',
                        ),
                        ListButtons(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RichAlertDialog(
                                    alertTitle:
                                        richTitle("Log-out from the App"),
                                    alertSubtitle:
                                        richSubtitle('Are you Sure '),
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
                          icon: Icons.exit_to_app,
                          text: 'Sign Out',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Divider(
                          indent: 30,
                          endIndent: 30,
                          thickness: 1.5,
                          color: Colors.grey.shade200,
                        ),
                        ListButtons(
                          onTap: () {},
                          icon: Icons.share,
                          text: 'Share Companion ',
                        ),
                        ListButtons(
                          onTap: () {},
                          icon: Icons.help_outline,
                          text: 'Help and Feedback',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListButtons extends StatelessWidget {
  final String text;
  final icon;
  final onTap;
  ListButtons({this.text, this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 9),
      child: InkWell(
        splashColor: Color(0xffBA6ABC3),
        onTap: onTap,
        focusColor: Colors.green,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            leading: Icon(
              icon,
              size: 25,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}

class FormItem extends StatelessWidget {
  final String hintText;
  final String helperText;
  final Function onChanged;
  final bool isNumber;
  final IconData icon;
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

class ElderlyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 56;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Elderly '),
              Text(
                'Care',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 1,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.perm_identity,
                  size: 30,
                  color: Color(0xff5e444d),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
