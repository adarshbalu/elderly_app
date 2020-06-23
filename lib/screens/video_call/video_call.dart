import 'dart:io';

import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';

class VideoCall extends StatefulWidget {
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final serverText = TextEditingController();
  TextEditingController roomText = TextEditingController(text: 'TestRoom');
  TextEditingController subjectText =
      TextEditingController(text: " Test Meeting");
  TextEditingController nameText = TextEditingController(text: " Test User");
  TextEditingController emailText =
      TextEditingController(text: "fake@email.com");
  TextEditingController iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  var isAudioOnly = false;
  var isAudioMuted = false;
  var isVideoMuted = false;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        title: Text(nameText.text),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              TextField(
                readOnly: true,
                controller: serverText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Server URL",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                readOnly: true,
                controller: roomText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Room",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                readOnly: true,
                controller: subjectText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Subject",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                readOnly: true,
                controller: nameText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Display Name",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                readOnly: true,
                controller: emailText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Platform.isIOS
                  ? TextField(
                      controller: iosAppBarRGBAColor,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "AppBar Color(IOS only)",
                          hintText: "Hint: This HAS to be in HEX RGBA format"),
                    )
                  : SizedBox(),
              SizedBox(
                height: 16.0,
              ),
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
                    "Join Meeting",
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
        ),
      ),
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
}
