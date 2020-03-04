import 'package:elderly_app/screens/home_screen.dart';
import 'package:elderly_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/screens/contact_relatives_screen.dart';
import 'package:elderly_app/screens/medicine_reminder.dart';
import 'package:elderly_app/screens/login_screen.dart';
import 'package:elderly_app/screens/profile_edit_screen.dart';
import 'package:elderly_app/screens/note_edit_screen.dart';
import 'package:elderly_app/screens/note_home_screen.dart';
import 'screens/reminder_detail.dart';
import 'screens/nearby_hospital_screen.dart';
import 'screens/initial_setup_screen.dart';
import 'screens/edit_relatives.dart';
import 'resources/service_locator.dart';

void main() {
  setupLocator();
  runApp(ElderlyApp());
}

class ElderlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elderly Care',
      initialRoute: LoadingScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        MedicineReminder.id: (context) => MedicineReminder(),
        LoadingScreen.id: (context) => LoadingScreen(),
        ContactScreen.id: (context) => ContactScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ProfileEdit.id: (context) => ProfileEdit(),
        NoteList.id: (context) => NoteList(),
        ReminderDetail.id: (context) => ReminderDetail(),
        NearbyHospital.id: (context) => NearbyHospital(),
        InitialSetupScreen.id: (context) => InitialSetupScreen(),
        EditRelativesScreen.id: (context) => EditRelativesScreen()
      },
      theme: ThemeData(
        fontFamily: 'OpenSans',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        textTheme: TextTheme(
            display1: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        )),
      ),
    );
  }
}
