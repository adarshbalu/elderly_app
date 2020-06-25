import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/user.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:http/http.dart' as http;
import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';

class VideoCall extends StatefulWidget {
  final String userID;

  const VideoCall({Key key, this.userID}) : super(key: key);
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final serverText = TextEditingController();
  TextEditingController roomText;
  TextEditingController subjectText =
      TextEditingController(text: "Urgent Video Call");
  TextEditingController nameText = TextEditingController(text: "");
  TextEditingController emailText = TextEditingController(text: "");
  TextEditingController iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  var isAudioOnly = false;
  var isAudioMuted = false;
  var isVideoMuted = false;

  @override
  void initState() {
    super.initState();
    roomText = TextEditingController(text: widget.userID);
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    serverText.dispose();
    roomText.dispose();
    subjectText.dispose();
    nameText.dispose();
    emailText.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElderlyAppBar(),
      drawer: AppDrawer(),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('profile')
              .document(widget.userID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserProfile userProfile = UserProfile(widget.userID);
              userProfile.setData(snapshot.data.data);
              roomText.value = TextEditingValue(text: userProfile.uid);
              nameText.value = TextEditingValue(text: userProfile.userName);
              emailText.value = TextEditingValue(text: userProfile.email);
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text("Audio Only"),
                      value: isAudioOnly,
                      onChanged: _onAudioOnlyChanged,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    CheckboxListTile(
                      title: Text("Audio Muted"),
                      value: isAudioMuted,
                      onChanged: _onAudioMutedChanged,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    CheckboxListTile(
                      title: Text("Video Muted"),
                      value: isVideoMuted,
                      onChanged: _onVideoMutedChanged,
                    ),
                    Divider(
                      height: 48.0,
                      thickness: 2.0,
                    ),
                    SizedBox(
                      height: 64.0,
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: () {
                          _joinMeeting();
                        },
                        child: Text(
                          "Start now",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                  ],
                ),
              );
            } else
              return CircularProgressIndicator();
          }),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      debugPrint("Jitsi MeetingOptions: $options");
      await JitsiMeet.joinMeeting(options,
          listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
            debugPrint("${options.room} will join with message: $message");
          }, onConferenceJoined: ({message}) {
            debugPrint("${options.room} joined with message: $message");
          }, onConferenceTerminated: ({message}) {
            debugPrint("${options.room} terminated with message: $message");
          }));
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broad-casted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broad-casted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broad-casted with message: $message");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  sendSMS() async {
    var cred =
        'AC07a649c710761cf3a0e6b96048accf58:ff835258561a7da33fe49ce779f745d4';

    var bytes = utf8.encode(cred);

    var base64Str = base64.encode(bytes);

    var url =
        'https://api.twilio.com/2010-04-01/Accounts/AC07a649c710761cf3a0e6b96048accf58/Messages.json';

    var response = await http.post(url, headers: {
      'Authorization': 'Basic $base64Str'
    }, body: {
      'From': '+12567403927',
      'To': '+918087214942',
      'Body': 'Please come in for urgent video call.'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
