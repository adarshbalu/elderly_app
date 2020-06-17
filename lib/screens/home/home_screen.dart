import 'package:elderly_app/screens/appoinment_reminder/appoinment_reminder_screen.dart';
import 'package:elderly_app/screens/document/view_documents_screen.dart';
import 'package:elderly_app/screens/hospital/nearby_hospital_screen.dart';
import 'package:elderly_app/screens/login/initial_setup_screen.dart';
import 'package:elderly_app/screens/medicine_reminder/medicine_reminder.dart';
import 'package:elderly_app/screens/notes/note_home_screen.dart';
import 'package:elderly_app/screens/pages/heart_rate_screen.dart';
import 'package:elderly_app/screens/relatives/contact_relatives_screen.dart';
import 'package:elderly_app/screens/trackers/tracker_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elderly_app/widgets/home_screen_widgets.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:elderly_app/screens/loading/onBoarding_screen.dart';
import 'package:elderly_app/others/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:permission_handler/permission_handler.dart'
    as PermissionManager;
import 'package:flutter_android/android_hardware.dart'
    show Sensor, SensorEvent, SensorManager;

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var sensor;
  bool initialSetupComplete = true;
  bool heartRateSensor = false;
  checkSensor() async {
    try {
      sensor = await SensorManager.getDefaultSensor(Sensor.TYPE_HEART_RATE);
      var events = await sensor.subscribe();
      events.listen((SensorEvent event) {
        print(event.values[0]);
        if (mounted)
          setState(() {
            heartRateSensor = true;
          });
      });
    } catch (e) {
      if (e == NoSuchMethodError) {
        if (mounted)
          setState(() {
            heartRateSensor = false;
          });
      }
    }
  }

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  Future checkLocationPermission() async {
    permission = await PermissionManager.PermissionHandler()
        .checkPermissionStatus(PermissionManager.PermissionGroup.location);
    PermissionManager.ServiceStatus serviceStatus =
        await PermissionManager.PermissionHandler()
            .checkServiceStatus(PermissionManager.PermissionGroup.location);

    if (permission == PermissionManager.PermissionStatus.granted) {
      setState(() {
        permissionGranted = true;
      });

      if (serviceStatus == PermissionManager.ServiceStatus.enabled) {
        setState(() {
          serviceEnabled = true;
        });
      } else {
        await location.requestService();
      }
    } else if (permission == PermissionManager.PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  bool permissionGranted = false;
  bool serviceEnabled = false;
  PermissionManager.PermissionStatus permission;
  @override
  Widget build(BuildContext context) {
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: ElderlyAppBar(),
      body: WillPopScope(
          onWillPop: () async {
            return showDialog(
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
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return true;
            },
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.purple,
                            child: CardButton(
                              height: screenHeight * 0.2,
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.userMd,
                              size: screenWidth * (25 / 100),
                              color: Color(0xff7b1fa2),
                              borderColor: Color(0xff7b1fa2).withOpacity(0.75),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppoinmentReminder.id);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text('Appoinment Reminder'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.yellowAccent,
                            child: CardButton(
                              height: screenHeight * (20 / 100),
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.capsules,
                              size: screenWidth * 0.2,
                              color: Color(0xffE3952D),
                              borderColor: Color(0xffE3952D).withOpacity(0.75),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, MedicineReminder.id);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text('Add Medicine Reminder'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.green,
                            child: CardButton(
                              height: screenHeight * (20 / 100),
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.hospital,
                              size: screenWidth * (25 / 100),
                              color: Color(0xff3c513d),
                              borderColor: Color(0xff3c513d).withOpacity(0.75),
                            ),
                            onTap: () async {
                              await checkLocationPermission();
                              if (serviceEnabled && permissionGranted) {
                                Navigator.pushNamed(
                                    context, NearbyHospitalScreen.id);
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Locate Nearby Hospital',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.indigo[300],
                            child: CardButton(
                              height: screenHeight * (20 / 100),
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.child,
                              size: screenWidth * (25 / 100),
                              color: Color(0xffaf5676),
                              borderColor: Color(0xffaf5676).withOpacity(0.75),
                            ),
                            onTap: () async {
                              if (initialSetupComplete) {
                                await checkLocationPermission();
                                if (serviceEnabled && permissionGranted) {
                                  Navigator.pushNamed(
                                      context, ContactScreen.id);
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RichAlertDialog(
                                        alertTitle: richTitle("Setup Error"),
                                        alertSubtitle: richSubtitle(
                                            'Initial setup not complete '),
                                        alertType: RichAlertType.ERROR,
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Do it now"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(context,
                                                  InitialSetupScreen.id);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text('Contact Relatives'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.redAccent,
                            child: CardButton(
                              height: screenHeight * 0.2,
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.heartbeat,
                              size: screenWidth * (25 / 100),
                              color: Color(0xffD83B36),
                              borderColor: Color(0xffD83B36).withOpacity(0.75),
                            ),
                            onTap: () {
                              if (heartRateSensor) {
                                Navigator.pushNamed(
                                    context, HeartRateScreen.id);
                              } else {
                                print('Heart Rate Sensor not available');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RichAlertDialog(
                                        alertTitle:
                                            richTitle("Function not available"),
                                        alertSubtitle: richSubtitle(
                                            'Sensor not available in device '),
                                        alertType: RichAlertType.WARNING,
                                        actions: <Widget>[
                                          FlatButton(
                                              child: Text("Ok"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      );
                                    });
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text('Check your Heart rate'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.brown,
                            child: CardButton(
                              height: screenHeight * (20 / 100),
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.fileAlt,
                              size: screenWidth * 0.2,
                              color: Color(0xff5d4037),
                              borderColor: Color(0xff5d4037).withOpacity(0.75),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, ViewDocuments.id);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text('Save Documents'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.teal,
                            child: CardButton(
                              height: screenHeight * 0.2,
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.stickyNote,
                              size: screenWidth * (25 / 100),
                              color: Color(0xff00796b),
                              borderColor: Color(0xff00796b).withOpacity(0.75),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, NoteList.id);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text('Take a Note'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.blue,
                            child: CardButton(
                              height: screenHeight * (20 / 100),
                              width: screenWidth * (35 / 100),
                              icon: FontAwesomeIcons.notesMedical,
                              size: screenWidth * 0.2,
                              color: Color(0xff3d5afe),
                              borderColor: Color(0xff3d5afe).withOpacity(0.75),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return TrackerHome();
                              }));
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text('Health Tracker'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * (5 / 100),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 55.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.redAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 3.0,
                            offset: Offset(0, 4.0),
                          ),
                        ],
                      ),
                      child: Text(
                        'Urgent',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => OnBoardingScreen()));
        },
      ),
    );
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
}
