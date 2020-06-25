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
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:elderly_app/others/notification_service.dart';

NotificationAppLaunchDetails notificationAppLaunchDetails;
NotificationService notificationService;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationService = NotificationService();
  notificationService.initialize();
  notificationAppLaunchDetails =
      await notificationService.notificationDetails();

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
        AppoinmentDetail.id: (context) => AppoinmentDetail(
              Appoinment('', '', '', '', 999999, false),
              '',
            ),
        ViewDocuments.id: (context) => ViewDocuments(),
        AddDocuments.id: (context) => AddDocuments(),
        ImageLabel.id: (context) => ImageLabel(),
        AppoinmentDecision.id: (context) =>
            AppoinmentDecision(Appoinment('', '', '', '', 999999, false)),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
      },
      theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white,
          textTheme:
              TextTheme().apply(fontFamily: GoogleFonts.lato().fontFamily)),
    );
  }
}
