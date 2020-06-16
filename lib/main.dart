import 'package:elderly_app/models/appoinment.dart';
import 'package:elderly_app/models/reminder.dart';
import 'package:elderly_app/others/auth.dart';
import 'package:elderly_app/resources/service_locator.dart';
import 'package:elderly_app/screens/appoinment_reminder/appoinment_decision_screen.dart';
import 'package:elderly_app/screens/appoinment_reminder/appoinment_detail_screen.dart';
import 'package:elderly_app/screens/appoinment_reminder/appoinment_reminder_screen.dart';
import 'package:elderly_app/screens/document/add_documents_screen.dart';
import 'package:elderly_app/screens/document/view_documents_screen.dart';
import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:elderly_app/screens/hospital/nearby_hospital_screen.dart';
import 'package:elderly_app/screens/loading/loading_screen.dart';
import 'package:elderly_app/screens/loading/onBoarding_screen.dart';
import 'package:elderly_app/screens/login/initial_setup_screen.dart';
import 'package:elderly_app/screens/login/login_screen.dart';
import 'package:elderly_app/screens/medicine_reminder/medicine_decision_screen.dart';
import 'package:elderly_app/screens/medicine_reminder/medicine_reminder.dart';
import 'package:elderly_app/screens/medicine_reminder/reminder_detail.dart';
import 'package:elderly_app/screens/notes/note_home_screen.dart';
import 'package:elderly_app/screens/pages/heart_rate_screen.dart';
import 'package:elderly_app/screens/pages/image_label.dart';
import 'package:elderly_app/screens/profile/profile_edit_screen.dart';
import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:elderly_app/screens/relatives/contact_relatives_screen.dart';
import 'package:elderly_app/screens/relatives/edit_relatives.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() {
  setupLocator();
  FlutterDownloader.initialize(debug: false);
  runApp(ElderlyApp());
}

class ElderlyApp extends StatelessWidget {
  Reminder reminder;
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('lib/resources/images/loadingimage.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elderly Care',
      initialRoute: LoadingScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        HeartRateScreen.id: (context) => HeartRateScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        MedicineReminder.id: (context) => MedicineReminder(),
        LoadingScreen.id: (context) => LoadingScreen(
              auth: Auth(),
            ),
        ContactScreen.id: (context) => ContactScreen(),
        LoginScreen.id: (context) => LoginScreen(
              auth: Auth(),
            ),
        ProfileEdit.id: (context) => ProfileEdit(),
        NoteList.id: (context) => NoteList(),
        ReminderDetail.id: (context) => ReminderDetail(reminder, ''),
        NearbyHospitalScreen.id: (context) => NearbyHospitalScreen(),
        InitialSetupScreen.id: (context) => InitialSetupScreen(),
        EditRelativesScreen.id: (context) => EditRelativesScreen(''),
        AppoinmentReminder.id: (context) => AppoinmentReminder(),
        AppoinmentDetail.id: (context) =>
            AppoinmentDetail(Appoinment('', '', '', ''), ''),
        ViewDocuments.id: (context) => ViewDocuments(),
        AddDocuments.id: (context) => AddDocuments(),
        ImageLabel.id: (context) => ImageLabel(),
        AppoinmentDecision.id: (context) => AppoinmentDecision(),
        MedicineScreen.id: (context) => MedicineScreen(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
      },
      theme: ThemeData(
        fontFamily: 'OpenSans',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        textTheme: TextTheme(
            headline4: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
            headline1: TextStyle(
              color: Colors.red,
              fontSize: 25,
            )),
      ),
    );
  }
}
