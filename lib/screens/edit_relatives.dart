import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/screens/contact_relatives_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'profile_screen.dart';
import 'package:http/http.dart' as http;

class EditRelativesScreen extends StatefulWidget {
  static const String id = 'Edit_Relatives_Screen';
  @override
  _EditRelativesScreenState createState() => _EditRelativesScreenState();
}

class _EditRelativesScreenState extends State<EditRelativesScreen> {
  TextEditingController relative1nameController;
  TextEditingController relative2nameController;
  TextEditingController relative2numController;
  TextEditingController relative1numController;

  @override
  void dispose() {
    relative1nameController.dispose();
    relative1numController.dispose();
    relative2nameController.dispose();
    relative2numController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getCurrentUser();
    populateData();
    super.initState();
  }

  String relative1name = '',
      relative2name = '',
      relative1num = '',
      relative2num = '';
  bool load = false;
  FirebaseUser loggedInUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String userId, username;
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      loggedInUser = user;
      userId = loggedInUser.uid;
      print(userId);
      await getUserRelativeData();
      await populateData();
    } catch (e) {
      print(e);
    }
  }

  final fireStoreDatabase = Firestore.instance;
  Future getUserRelativeData() async {
    await fireStoreDatabase
        .collection('profile')
        .document(userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      print(snapshot.data);
      if (mounted)
        setState(() {
          relative2name = snapshot.data['relative2name'];
          relative1name = snapshot.data['relative1name'];
          relative2num = snapshot.data['relative2number'];
          relative1num = snapshot.data['relative1number'];
          username = snapshot.data['userName'];

          load = true;
        });
    });
  }

  Future populateData() async {
    await fireStoreDatabase
        .collection('profile')
        .document(userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      print(snapshot.data['age']);
      if (mounted)
        setState(() {
          relative2numController = TextEditingController(text: relative2num);
          relative2nameController = TextEditingController(text: relative2name);
          relative1nameController = TextEditingController(text: relative1name);
          relative1numController = TextEditingController(text: relative1num);
          load = true;
        });
    });
  }

  Future updateRelativeData() async {
    try {
      await fireStoreDatabase
          .collection('profile')
          .document(userId)
          .updateData({
        'relative1num': relative1num,
        'relative2num': relative2num,
        'relative1name': relative1name,
        'relative2name': relative2name,
      });
    } catch (e) {
      print(e.toString());
    }
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
              print('Profile Button Tapped');
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
      body: ListView(
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
          Center(
            child: Text(
              'Relative 1 ',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Name : ')),
                Expanded(
                  flex: 6,
                  child: FormItem(
                    helperText: 'Name of the Relative 1',
                    hintText: 'Enter  Name',
                    controller: relative1nameController,
                    onChanged: (value) {
                      print('Name Saved');
                      setState(() {
                        relative1name = value;
                      });
                    },
                    isNumber: false,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Num : ')),
                Expanded(
                  flex: 6,
                  child: FormItem(
                    helperText: 'Number of the Relative 1',
                    hintText: 'Enter  Number',
                    controller: relative1numController,
                    onChanged: (value) {
                      print('Name Saved');
                      setState(() {
                        relative1num = value.toString();
                      });
                    },
                    isNumber: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Relative 2 ',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Name : ')),
                Expanded(
                  flex: 6,
                  child: FormItem(
                    helperText: 'Name of the Relative 2',
                    hintText: 'Enter  Name',
                    controller: relative2nameController,
                    onChanged: (value) {
                      print('Name Saved');
                      setState(() {
                        relative2name = value;
                      });
                    },
                    isNumber: false,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Num : ')),
                Expanded(
                  flex: 6,
                  child: FormItem(
                    helperText: 'Number of the Relative 2',
                    hintText: 'Enter  Number',
                    controller: relative2numController,
                    onChanged: (value) {
                      print('Name Saved');
                      setState(() {
                        relative2num = value.toString();
                      });
                    },
                    isNumber: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: MaterialButton(
              color: Colors.green,
              onPressed: () async {
                await updateRelativeData();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ContactScreen()),
                    (Route<dynamic> route) => false);
              },
              padding: EdgeInsets.all(15),
              child: Text(
                'Update Details',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
