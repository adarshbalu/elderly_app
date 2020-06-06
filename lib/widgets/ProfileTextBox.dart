import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTextBox extends StatefulWidget {
  final String title, value, name;

  ProfileTextBox({this.title, this.value, this.name});

  @override
  _ProfileTextBoxState createState() => _ProfileTextBoxState();
}

class _ProfileTextBoxState extends State<ProfileTextBox> {
  @override
  void initState() {
    getCurrentUser();
    controller =
        TextEditingController.fromValue(TextEditingValue(text: widget.value));
    super.initState();
  }

  TextEditingController controller;

  String currentUserId;

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      currentUserId = user.uid;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TextField(
          controller: controller,
          onChanged: (v) async {
            await Firestore.instance
                .collection('profile')
                .document(currentUserId)
                .updateData({widget.name: v});
          },

          style: TextStyle(color: Colors.black), //const Color(0xffeeeff1) ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffeeeff1)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              labelStyle: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              labelText: widget.title.toUpperCase()),
        ),
      ),
    );
  }
}
