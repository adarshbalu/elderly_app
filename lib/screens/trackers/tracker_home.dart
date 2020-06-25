import 'package:elderly_app/screens/trackers/sleep/add_sleep_screen.dart';
import 'package:elderly_app/screens/trackers/sleep/sleep_tracker_screen.dart';
import 'package:elderly_app/screens/trackers/weight/add_weight.dart';
import 'package:elderly_app/screens/trackers/weight/weight_tracker_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrackerHome extends StatefulWidget {
  @override
  _TrackerHomeState createState() => _TrackerHomeState();
}

class _TrackerHomeState extends State<TrackerHome> {
  Map<String, bool> hideMap, trackMap;
  initializeDisplayMap() {
    hideMap = Map<String, bool>();
    trackMap = Map<String, bool>();
    hideMap = {'sleep': true, 'weight': true, 'sugar': true, 'pressure': true};
    trackMap = {
      'sleep': false,
      'weight': true,
      'sugar': true,
      'pressure': true
    };
  }

  onHide(String type) {
    setState(() {
      hideMap[type] = false;
    });
  }

  @override
  void initState() {
    initializeDisplayMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElderlyAppBar(),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Text(
                'Health Trackers',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff3d5afe),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TrackerCard(
            title: 'Sleep Tracker',
            subTitle:
                'How Long did you sleep last night ?\nTrack hours slept to understand sleep patterns.',
            onAdd: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AddSleepScreen();
              }));
            },
            onHide: () => onHide('sleep'),
            onView: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SleepTrackerScreen();
              }));
            },
            isHidden: hideMap['sleep'],
            isTracking: true,
          ),
          TrackerCard(
            title: 'Weight Tracker',
            subTitle:
                '\nHow much did you weigh ? Track to see progress over time.\n',
            onAdd: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AddWeightScreen();
              }));
            },
            onHide: () => onHide('weight'),
            onView: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return WeightTrackerScreen();
              }));
            },
            isHidden: hideMap['weight'],
            isTracking: trackMap['weight'],
          ),
          TrackerCard(
            title: 'Blood Glucose',
            subTitle:
                '\nWhat\'s your blood sugar level ? Track to chart progress.\n',
            onAdd: () {},
            onHide: () => onHide('sugar'),
            onView: () {},
            isHidden: hideMap['sugar'],
            isTracking: trackMap['sugar'],
          ),
          TrackerCard(
            title: 'Blood Pressure',
            subTitle:
                '\nWhat\'s your blood pressure reading ?Track to see progress over time.\n',
            onAdd: () {},
            onHide: () => onHide('pressure'),
            onView: () {},
            isHidden: hideMap['pressure'],
            isTracking: trackMap['pressure'],
          ),
        ],
      ),
    );
  }
}

class TrackerCard extends StatelessWidget {
  final String title, subTitle;
  final onHide, onAdd, onView;
  final bool isTracking, isHidden;
  TrackerCard(
      {this.title,
      this.isHidden,
      this.onAdd,
      this.onHide,
      this.subTitle,
      this.onView,
      this.isTracking});
  @override
  Widget build(BuildContext context) {
    if (isHidden) {
      return Card(
        elevation: 2,
        color: Colors.grey.shade50,
        margin: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 3.3,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.poll,
                        color: Color(0xff3d5afe),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isTracking
                      ? RaisedButton(
                          onPressed: onView,
                          elevation: 2,
                          textColor: Color(0xff3d5afe),
                          child: Text(
                            'View Chart',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Color(0xff3d5afe),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                        )
                      : RaisedButton(
                          onPressed: onHide,
                          elevation: 2,
                          textColor: Color(0xff3d5afe),
                          child: Text(
                            'Hide',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Color(0xff3d5afe),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                        ),
                  SizedBox(
                    width: 25,
                  ),
                  RaisedButton(
                      color: Color(0xff3d5afe),
                      elevation: 2,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Add data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: onAdd),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
