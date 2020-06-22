import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initialize() async {
    this.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
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

  scheduleNotification(
      {@required int id,
      @required String title,
      @required String body,
      @required DateTime dateTime}) async {
    var scheduledNotificationDateTime = dateTime;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Elderly Care', 'Elderly Care', 'Elderly Care Notification');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(id, title, body,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  periodicNotification(
      {@required int id,
      @required String title,
      @required String body,
      @required DateTime dateTime}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
  }

  dailyNotification() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ',
        time,
        platformChannelSpecifics);
  }

  weeklyNotification() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'show weekly title',
        'Weekly notification shown on Monday at approximately',
        Day.Monday,
        time,
        platformChannelSpecifics);
  }

  notificationDetails() async {
    var notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    print(notificationAppLaunchDetails.didNotificationLaunchApp);
    print(notificationAppLaunchDetails.payload);
    return notificationAppLaunchDetails;
  }

  Future onNotificationSelect(String payload) async {
    debugPrint("PAYLOAD : " + payload);

    return true;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
//    didReceiveLocalNotificationSubject.add(ReceivedNotification(
//        id: id, title: title, body: body, payload: payload));
  }

  Future<void> deleteNotification(int id) async {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
