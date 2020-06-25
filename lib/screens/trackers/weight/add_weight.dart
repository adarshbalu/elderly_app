import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/tracker.dart';
import 'package:elderly_app/screens/trackers/weight/weight_tracker_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddWeightScreen extends StatefulWidget {
  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final _trackerKey = GlobalKey<FormState>();
  TextEditingController weight, notes;
  WeightTracker weightTracker;

  @override
  void initState() {
    weightTracker = WeightTracker();
    weight = TextEditingController(text: '');
    notes = TextEditingController(text: '');
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Text(
                  'Add Weight Data',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xff3d5afe),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _trackerKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: weight,
                      decoration: InputDecoration(
                        hintText: 'Weight in kg',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        _trackerKey.currentState.validate();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter weight';
                        } else {
                          if (!isNumeric(value)) {
                            return 'Enter numeric value';
                          }
                          if (int.parse(value) < 0 || int.parse(value) > 200) {
                            return 'Enter Valid value';
                          }
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: TextFormField(
                      onChanged: (v) {
                        _trackerKey.currentState.validate();
                      },
                      controller: notes,
                      decoration: InputDecoration(
                        hintText: 'Notes about weight ',
                        border: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter value';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton.icon(
                color: Color(0xff3d5afe),
                onPressed: () async {
                  _trackerKey.currentState.validate();
                  await saveData();
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => WeightTrackerScreen()));
                },
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.add),
                label: Text('Add Data')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recommended weight is 75kg .'),
            )
          ],
        ),
      ),
      appBar: ElderlyAppBar(),
      drawer: AppDrawer(),
    );
  }

  saveData() async {
    weightTracker.weightData = Weight(
        weight: int.parse(weight.text),
        notes: notes.text,
        dateTime: DateTime.now());
    await Firestore.instance
        .collection('tracker')
        .document(userId)
        .collection('weight')
        .add(weightTracker.toMap());
  }

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  String userId;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}
