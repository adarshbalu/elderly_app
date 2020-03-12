import 'dart:io';
import 'package:elderly_app/screens/initial_setup_screen.dart';
import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class AddDocuments extends StatefulWidget {
  static const String id = 'Add_Documents_Screen';
  @override
  _AddDocumentsState createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  File localImage;
  Future pickImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var path;
    path = await getApplicationDocumentsDirectory();

    var fileName = basename(image.path);
    localImage = await image.copy('$path/$fileName');
  }

  TextEditingController docNameController = TextEditingController();
  String docName;

  Future saveImage() async {
    String name = docName.toLowerCase();
    name = name.replaceAll(' ', '');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$name', localImage.path);
  }

  @override
  void dispose() {
    docNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Add Documents  ',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          FormItem(
            isNumber: false,
            hintText: 'File Name :',
            controller: docNameController,
            onChanged: (value) {
              setState(() {
                docName = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                if (docName != null) {
                  await pickImage();
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RichAlertDialog(
                          alertTitle: richTitle("File Name Field Empty"),
                          alertSubtitle:
                              richSubtitle('Please provide a file name'),
                          alertType: RichAlertType.INFO,
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                }
              },
              child: Icon(Icons.image),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(50, 20, 50, 30),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 65.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 3.0,
                    offset: Offset(0, 4.0),
                  ),
                ],
              ),
              child: Text(
                'Save Image',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Text('Remember the File name.Don\'t add spaces between words')
        ],
      ),
    );
  }
}
