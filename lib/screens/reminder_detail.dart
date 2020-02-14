import 'package:flutter/material.dart';
import 'profile_screen.dart';

class ReminderDetail extends StatefulWidget {
  static const String id = 'Medicine_detail_screen';
  @override
  _ReminderDetailState createState() => _ReminderDetailState();
}

class _ReminderDetailState extends State<ReminderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Edit Details',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xffE3952D),
                ),
              ),
            ),
          ),
          ReminderFormItem(
            hintText: 'Enter Medicine Name',
            //onSaved: () {
            // print('Name Saved');
            //},
            isNumber: false,
          ),
          ReminderFormItem(
            hintText: 'Enter times a day ',
            //onSaved: () {
            // print('Name Saved');
            //},
            isNumber: true,
          ),
        ],
      ),
    );
  }
}

class ReminderFormItem extends StatelessWidget {
  final String hintText;
  //final Function onSaved;
  final bool isNumber;
  ReminderFormItem({
    this.hintText,
    //this.onSaved,
    this.isNumber: false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          fillColor: Colors.grey[200],
        ),
        //    onSaved: onSaved,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
