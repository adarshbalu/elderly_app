import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/relative.dart';
import 'package:elderly_app/screens/relatives/relative_text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import '../profile/profile_screen.dart';

class EditRelativesScreen extends StatefulWidget {
  static const String id = 'Edit_Relatives_Screen';
  final String documentID;
  EditRelativesScreen(this.documentID);
  @override
  _EditRelativesScreenState createState() => _EditRelativesScreenState();
}

class _EditRelativesScreenState extends State<EditRelativesScreen> {
  String userId;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
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
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('profile')
              .document(userId)
              .collection('relatives')
              .document(widget.documentID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Relative relative = Relative();
              relative = relative.getData(snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                      child: Center(
                        child: Text(
                          'Edit Relatives Details',
                          style: TextStyle(fontSize: 30, color: Colors.amber),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: RelativeTextBox(
                          name: 'name',
                          value: relative.name,
                          title: 'Name ',
                          documentID: widget.documentID,
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: RelativeTextBox(
                          name: 'email',
                          value: relative.email,
                          title: 'email address',
                          documentID: widget.documentID,
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: RelativeTextBox(
                          name: 'phoneNumber',
                          value: relative.phoneNumber,
                          title: 'phone number',
                          documentID: widget.documentID,
                        )),
                    RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.green,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
