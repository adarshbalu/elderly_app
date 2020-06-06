import 'package:elderly_app/screens/profile/profile_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:elderly_app/others/functions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'Profile_Screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'NameofUser';
  final fireStoreDatabase = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String gender,
      userId,
      bloodGroup,
      allergies,
      email,
      bloodPressure,
      bloodSugar;
  int age;
  double height, weight;
  FirebaseUser loggedInUser;
  bool load = false;
  @override
  void initState() {
    getCurrentUser();
    getUserDetails();
    super.initState();
  }

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      loggedInUser = user;
      userId = loggedInUser.uid;
      print(userId);
      await getUserDetails();
//      if (loggedInUser.displayName != null) {
//        username = loggedInUser.displayName.toString();
//      }
    } catch (e) {
      print(e);
    }
  }

  Future getUserDetails() async {
    await fireStoreDatabase
        .collection('profile')
        .document(userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      print(snapshot.data);
      if (mounted)
        setState(() {
          age = snapshot.data['age'];
          username = snapshot.data['userName'];
          weight = snapshot.data['weight'];
          height = snapshot.data['height'];
          bloodGroup = snapshot.data['bloodGroup'];
          gender = snapshot.data['gender'];
          email = snapshot.data['email'];
          allergies = snapshot.data['allergies'];
          bloodSugar = snapshot.data['bloodSugar'];
          bloodPressure = snapshot.data['bloodPressure'];
          load = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    getUserDetails();
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

    double kTextSize = 19.0, kValueSize = 18.0;
    if (screenHeight > 641) {
      kTextSize = 23.0;
      kValueSize = 20.0;
    }

    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
        ),
        onPressed: () {
          print('Edit Button');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ProfileEdit(
                userId: userId,
              );
            }),
          );
        },
        backgroundColor: Color(0xff3c513d),
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
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade50,
              child: Icon(
                Icons.perm_identity,
                size: 30,
                color: Color(0xff5e444d),
              ),
            ),
          ),
        ],
      ),
      body: load
          ? ListView(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Color(0xff3c513d),
                      child: Icon(
                        Icons.account_circle,
                        size: 90.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    username,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w100),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.green, style: BorderStyle.solid),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 10.0, bottom: 20),
                    child: Text(
                      'Profile Details',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffE3952D),
                      ),
                    ),
                  ),
                ),
                ProfileDetails(
                  detailName: 'AGE',
                  detailValue: age.toString(),
                  textSize: kTextSize,
                  valueSize: kValueSize,
                ),
                ProfileDetails(
                  textSize: kTextSize,
                  valueSize: kValueSize,
                  detailName: 'Gender',
                  detailValue: gender,
                ),
                ProfileDetails(
                  detailName: 'HEIGHT',
                  detailValue: height.toString(),
                  textSize: kTextSize,
                  valueSize: kValueSize,
                ),
                ProfileDetails(
                  detailName: 'WEIGHT',
                  valueSize: kValueSize,
                  textSize: kTextSize,
                  detailValue: weight.toString(),
                ),
                ProfileDetails(
                  valueSize: kValueSize,
                  textSize: kTextSize,
                  detailName: 'BLOOD GROUP',
                  detailValue: bloodGroup,
                ),
                ProfileDetails(
                  textSize: kTextSize,
                  valueSize: kValueSize,
                  detailName: 'BLOOD PRESSURE',
                  detailValue: bloodPressure,
                ),
                ProfileDetails(
                  textSize: kTextSize,
                  valueSize: kValueSize,
                  detailName: 'BLOOD SUGAR',
                  detailValue: bloodSugar,
                ),
                ProfileDetails(
                  textSize: kTextSize,
                  valueSize: kValueSize,
                  detailName: 'Allergies',
                  detailValue: allergies,
                ),
                ProfileDetails(
                  textSize: kTextSize,
                  valueSize: kValueSize,
                  detailName: 'E-mail Address',
                  detailValue: email,
                ),
                SizedBox(
                  height: 25.0,
                )
              ],
            )
          : Container(
              child: SpinKitWanderingCubes(
                color: Colors.green,
                size: 100.0,
              ),
            ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  String detailName, detailValue;
  double textSize, valueSize;
  ProfileDetails(
      {this.detailName, this.detailValue, this.textSize, this.valueSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(21.0),
      margin: EdgeInsets.only(right: 1, left: 10, top: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '$detailName : ',
              style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              '$detailValue',
              style: TextStyle(
                  fontSize: valueSize,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}
