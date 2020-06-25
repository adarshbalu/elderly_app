import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/tracker.dart';
import 'package:flutter/material.dart';

class TimeChart extends StatefulWidget {
  final bool animate;
  final String userID;
  TimeChart({
    this.animate,
    this.userID,
  });

  @override
  _TimeChartState createState() => _TimeChartState();
}

class _TimeChartState extends State<TimeChart> {
  SleepTracker sleepTracker;
  List<charts.Series> seriesList;

  @override
  void initState() {
    _createSampleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _createSampleData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return charts.TimeSeriesChart(
              snapshot.data,
              animate: widget.animate,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  Future<List<charts.Series<Sleep, DateTime>>> _createSampleData() async {
    sleepTracker = SleepTracker();
    QuerySnapshot snapshot = await Firestore.instance
        .collection('tracker')
        .document(widget.userID)
        .collection('sleep')
        .getDocuments();

    List list = sleepTracker.loadData(snapshot);

    return [
      charts.Series<Sleep, DateTime>(
        id: 'Sleep Tracking',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Sleep sleep, _) => DateTime(
            sleep.dateTime.year, sleep.dateTime.month, sleep.dateTime.day),
        measureFn: (Sleep sleep, _) => sleep.hours + sleep.minutes / 60,
        data: list,
      )
    ];
  }
}

