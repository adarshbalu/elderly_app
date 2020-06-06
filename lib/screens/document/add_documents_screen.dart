import 'dart:io';

import 'package:elderly_app/screens/document/view_documents_screen.dart';
import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class AddDocuments extends StatefulWidget {
  static const String id = 'Add_Documents_Screen';
  @override
  _AddDocumentsState createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  File image;
  var fileName;
  File loadedImage;

  Directory directory;
  var path;
  TextEditingController docNameController = TextEditingController();
  String docName;
  bool imageLoaded = false;

  Future pickImage() async {
    directory = await getApplicationDocumentsDirectory();
    path = directory.path;
    print(path);
    loadedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (loadedImage == null)
      return;
    else
      setState(() {
        imageLoaded = true;
      });
    print(loadedImage.path);
  }

  Future saveImage() async {
    String name = docName.toLowerCase();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, image.path);
  }

  Future copyImage() async {
    String extension = Path.basename(loadedImage.path);
    var s = extension.indexOf('.', 0);
    String ext = extension.substring(s, extension.length);
    image = await loadedImage.copy('$path/${docName + ext}');
  }

  void saveName(String value) {
    setState(() {
      docName = value;
    });
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
          SizedBox(
            height: 20,
          ),
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
            height: 25,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('File Name : '),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: 'Enter File name',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.indigo,
                                style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color(0xffaf5676),
                                style: BorderStyle.solid)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color(0xffaf5676),
                                style: BorderStyle.solid))),
                    onChanged: (value) {
                      setState(() {
                        docName = value;
                      });
                    },
                  ),
                ),
              ),
            ],
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
              child: Icon(
                Icons.image,
                size: 140,
                color: imageLoaded ? Colors.green : Colors.amberAccent,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                await copyImage();
                print(image.path);
                print(path);
                await saveImage();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RichAlertDialog(
                        alertTitle: richTitle("Image Saved"),
                        alertSubtitle: richSubtitle('Please remember the name'),
                        alertType: RichAlertType.SUCCESS,
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, ViewDocuments.id);
                              docNameController.clear();
                            },
                          ),
                        ],
                      );
                    });
              },
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Remember the File name.Don\'t add spaces between words'),
          )
        ],
      ),
    );
  }
}
