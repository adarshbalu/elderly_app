import 'package:flutter_android/android_hardware.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter_android/android_hardware.dart'
    show Sensor, SensorEvent, SensorManager;

class HeartRateScreen extends StatefulWidget {
  static const String id = 'Heart_rate_Screen';
  @override
  _HeartRateScreenState createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  var sensor;
  @override
  void initState() {
    super.initState();
  }

  bool heartRateSensor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Center(
        child: FlatButton(
          child: Text('Press'),
          onPressed: () async {
            try {
              sensor =
                  await SensorManager.getDefaultSensor(Sensor.TYPE_HEART_RATE);
              var events = await sensor.subscribe();
              events.listen((SensorEvent event) {
                print(event.values[0]);
                setState(() {
                  heartRateSensor = true;
                });
              });
            } catch (e) {
              if (e == NoSuchMethodError) {
                heartRateSensor = false;
              }
            }
          },
        ),
      ),
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
    );
  }
}
