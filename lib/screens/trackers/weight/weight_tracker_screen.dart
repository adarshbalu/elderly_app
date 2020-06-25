import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/tracker.dart';
import 'package:elderly_app/screens/trackers/sleep/chart_widget.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SleepTrackerScreen extends StatefulWidget {
  @override
  _SleepTrackerScreenState createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  QuerySnapshot snapshot;
  String userId;
  double averageSleep;
  SleepTracker sleepTracker;
  getDocumentList() async {
    sleepTracker = SleepTracker();
    snapshot = await Firestore.instance
        .collection('tracker')
        .document(userId)
        .collection('sleep')
        .getDocuments();
    averageSleep = 0;
    double totalSleep = 0;
    List<Sleep> list = sleepTracker.loadData(snapshot);
    for (var s in list) {
      totalSleep += s.hours + s.minutes / 60;
    }
    averageSleep = totalSleep / list.length;
    return snapshot;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Text(
                'Sleep Tracker',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff3d5afe),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: getDocumentList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.all(15),
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height / 1.7,
                            maxWidth: MediaQuery.of(context).size.width *
                                (snapshot.data.documents.length / 3),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TimeChart(
                                animate: true,
                                userID: userId,
                              ),
                            ),
                            margin: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: ListTile(
                          subtitle: Text('Average Sleep'),
                          title: Text(averageSleep.toStringAsFixed(2)),
                        ),
                      )
                    ],
                  );
                } else
                  return SizedBox();
              }),
        ],
      ),
      appBar: ElderlyAppBar(),
      drawer: AppDrawer(),
    );
  }
}
