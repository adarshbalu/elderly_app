import 'dart:io';
import 'package:elderly_app/models/user.dart';
import 'package:elderly_app/screens/profile/ProfileTextBox.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'Profile_Screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId, imageUrl = '';
  FirebaseUser loggedInUser;
  File imageFile;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
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
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('profile')
                .document(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserProfile userProfile = UserProfile(userId);
                userProfile.setData(snapshot.data.data);
                return ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(2000),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          NetworkImage(userProfile.picture)))),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await getImage();
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ProfileTextBox(
                      name: 'userName',
                      value: userProfile.userName,
                      title: 'name',
                    ),
                    ProfileTextBox(
                      name: 'age',
                      value: userProfile.age,
                      title: 'age',
                    ),
                    ProfileTextBox(
                      name: 'gender',
                      value: userProfile.gender,
                      title: 'gender',
                    ),
                    ProfileTextBox(
                      name: 'height',
                      value: userProfile.height,
                      title: 'height',
                    ),
                    ProfileTextBox(
                      name: 'weight',
                      value: userProfile.weight,
                      title: 'weight',
                    ),
                    ProfileTextBox(
                      name: 'bloodGroup',
                      value: userProfile.bloodGroup,
                      title: 'blood group',
                    ),
                    ProfileTextBox(
                      name: 'bloodPressure',
                      value: userProfile.bloodPressure,
                      title: 'blood pressure',
                    ),
                    ProfileTextBox(
                      name: 'bloodSugar',
                      value: userProfile.bloodSugar,
                      title: 'blood sugar',
                    ),
                    ProfileTextBox(
                      name: 'allergies',
                      value: userProfile.allergies,
                      title: 'allergies',
                    ),
                    ProfileTextBox(
                      name: 'email',
                      value: userProfile.email,
                      title: 'email address',
                    ),
                    ProfileTextBox(
                      name: 'phoneNumber',
                      value: userProfile.phoneNumber,
                      title: 'phone number',
                    ),
                    SizedBox(
                      height: 25.0,
                    )
                  ],
                );
              } else {
                return Container(
                  child: SpinKitWanderingCubes(
                    color: Colors.green,
                    size: 100.0,
                  ),
                );
              }
            }));
  }

  updateData(String name, String value) async {
    await Firestore.instance
        .collection('profile')
        .document(userId)
        .updateData({name: value});
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile.path);
    });
    if (imageFile != null) {
      setState(() {
//        isLoading = true;
      });
      await uploadFile(userId);
    }
  }

  Future uploadFile(String name) async {
    String fileName = name;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;

      setState(() {
//        isLoading = false;
      });
      updateData('picture', imageUrl);
    }, onError: (err) {
      setState(() {
//        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Text('Not an Image.'),
            );
          });
    });
  }
}
