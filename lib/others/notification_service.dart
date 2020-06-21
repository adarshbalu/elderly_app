import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initialize() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings(
        onDidReceiveLocalNotification: this.onDidReceiveLocalNotification);
    var initSetting = InitializationSettings(android, ios);
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: this.onNotificationSelect);
  }

  showNotification(
      {@required int id,
      @required String title,
      @required String body,
      String ticker}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Elderly Care', 'Elderly Care System', 'The Elderly Care Application',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: ticker ?? 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: 'item x');
  }

  scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future onNotificationSelect(String payload) async {
    debugPrint("PAYLOAD : " + payload);

    return true;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print("Hii");
          },
          child: Text("Okay"),
        )
      ],
    );
  }

  Future<void> deleteNotification(int id) async {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
