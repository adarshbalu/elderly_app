import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'OnBoarding_screen';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    startTime();
    initPrefs();
    controller = PageController();
    super.initState();
  }

  PageController controller;
  int currentPageValue;
  final List<Widget> introWidgetsList = <Widget>[
    Container(
      child: Text('hhh'),
    ),
    Container(
      child: Text('hhh'),
    ),
    Container(
      child: Text('hhh'),
    )
  ];
  SharedPreferences prefs;
  bool showOnBoarding = false;
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    showOnBoarding = prefs.getBool('first') ?? true;
  }

  startTime() async {
    var _duration = Duration(seconds: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PageView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: introWidgetsList.length,
            onPageChanged: (int page) {
              getChangedPageAndMoveBar(page);
            },
            controller: controller,
            itemBuilder: (context, index) {
              return introWidgetsList[index];
            },
          ),
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 35),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                    for (int i = 0; i < introWidgetsList.length; i++)
//                      if (i == currentPageValue) ...[circleBar(true)] else
//                        circleBar(false),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible:
                currentPageValue == introWidgetsList.length - 1 ? true : false,
            child: FloatingActionButton(
              onPressed: () {},
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(26))),
              child: Icon(Icons.arrow_forward),
            ),
          )
        ],
      )),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }
}
