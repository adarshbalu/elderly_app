import 'package:elderly_app/others/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'Profile_Screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
        ),
        onPressed: () {
          print('Edit Button');
        },
        backgroundColor: Color(0xff3c513d),
      ),
      appBar: AppBar(
        title: Text('Elderly Care'),
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
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
              'NameOfUser',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w100),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: Colors.green, style: BorderStyle.solid),
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
            detailValue: '67',
          ),
          ProfileDetails(
            detailName: 'HEIGHT',
            detailValue: '200',
          ),
          ProfileDetails(
            detailName: 'WEIGHT',
            detailValue: '50',
          ),
          ProfileDetails(
            detailName: 'BLOOD GROUP',
            detailValue: 'O+ve',
          ),
          ProfileDetails(
            detailName: 'BLOOD PRESSURE',
            detailValue: 'Normal',
          ),
        ],
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  String detailName, detailValue;

  ProfileDetails({this.detailName, this.detailValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(21.0),
      margin: EdgeInsets.only(right: 15, left: 15, top: 18),
      child: Row(
        children: <Widget>[
          Text(
            '$detailName : ',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          Text(
            '$detailValue',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
