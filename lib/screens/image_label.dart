import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';

class ImageLabel extends StatefulWidget {
  static const String id = 'Image_Detection_screen';
  @override
  _ImageLabelState createState() => _ImageLabelState();
}

class _ImageLabelState extends State<ImageLabel> {
  File _file;

  List<VisionLabel> _currentLabels = <VisionLabel>[];

  FirebaseVisionLabelDetector detector = FirebaseVisionLabelDetector.instance;

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
      body: _buildBody(_file),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            var file = await ImagePicker.pickImage(source: ImageSource.camera);
            setState(() {
              _file = file;
            });

            var currentLabels =
                await detector.detectFromBinary(_file?.readAsBytesSync());
            setState(() {
              _currentLabels = currentLabels;
            });
          } catch (e) {
            print(e.toString());
          }
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  //Build body
  Widget _buildBody(File _file) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Center(
              child: Text(
                'Image Detector',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          displaySelectedFile(_file),
          _buildList(_currentLabels)
        ],
      ),
    );
  }

  Widget _buildList(List<VisionLabel> labels) {
    if (labels == null || labels.length == 0) {
      return Center(
          child: Text(
        'Select an Image to continue ',
      ));
    }
    return Expanded(
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: labels.length,
            itemBuilder: (context, i) {
              return _buildRow(labels[i].label, labels[i].confidence.toString(),
                  labels[i].entityID);
            }),
      ),
    );
  }

  Widget displaySelectedFile(File file) {
    return Center(
      child: SizedBox(
        // height: 200.0,
        width: 150.0,
        child: file == null ? Text(' ') : Image.file(file),
      ),
    );
  }

  //Display labels
  Widget _buildRow(String label, String confidence, String entityID) {
    return new ListTile(
      title: new Text(
        "\nName: $label \nConfidence: $confidence ",
        //\nEntityID: $entityID
      ),
      dense: true,
    );
  }
}
