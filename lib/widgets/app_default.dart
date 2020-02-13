import 'package:elderly_app/screens/note_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/others/constants.dart';
import 'package:elderly_app/screens/note_edit_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
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
                      print('Drawer item Tapped');
                    },
                    splashColor: Color(0xff3c513d),
                    child: ListButtons(
                      icon: Icons.attach_file,
                      text: 'Add Documents',
                    ),
                  ),
                  InkWell(
                    splashColor: Color(0xff3c513d),
                    onTap: () {
                      print('Drawer item Tapped');
                    },
                    child: ListButtons(
                      icon: Icons.description,
                      text: 'View Documents',
                    ),
                  ),
                  InkWell(
                    splashColor: Color(0xff3c513d),
                    onTap: () {
                      print('Drawer item Tapped');
                    },
                    child: ListButtons(
                      icon: Icons.person_add,
                      text: 'Add Relatives',
                    ),
                  ),
                  InkWell(
                    splashColor: Color(0xff3c513d),
                    onTap: () {
                      print('Drawer item Tapped');
                    },
                    child: ListButtons(
                      icon: Icons.supervisor_account,
                      text: 'View Relatives',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Drawer item Tapped');
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
                      print('Drawer item Tapped');
                    },
                    child: ListButtons(
                      icon: Icons.local_hospital,
                      text: 'Appoinment Reminder',
                    ),
                  ),
                  InkWell(
                    splashColor: Color(0xff3c513d),
                    onTap: () {
                      print('Drawer item Tapped');
                    },
                    child: ListButtons(
                      icon: Icons.cancel,
                      text: 'Close App',
                    ),
                  )
                ],
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
