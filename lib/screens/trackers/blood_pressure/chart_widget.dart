import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/tracker.dart';
import 'package:flutter/material.dart';

class BloodPressureChart extends StatefulWidget {
  final bool animate;
  final String userID, type;
  BloodPressureChart({
    this.animate,
    this.userID,
    this.type,
  });

  @override
  _BloodPressureChartState createState() => _BloodPressureChartState();
}

class _BloodPressureChartState extends State<BloodPressureChart> {
  BloodPressureTracker bloodPressure;
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

  Future<List<charts.Series<BloodPressure, DateTime>>>
      _createSampleData() async {
    bloodPressure = BloodPressureTracker();
    QuerySnapshot snapshot = await Firestore.instance
        .collection('tracker')
        .document(widget.userID)
        .collection('blood_pressure')
        .getDocuments();

    List list = bloodPressure.loadData(snapshot);
    if (widget.type == 'diastolic')
      return [
        charts.Series<BloodPressure, DateTime>(
          id: 'Blood Pressure Diastolic Tracking',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (BloodPressure b, _) =>
              DateTime(b.dateTime.year, b.dateTime.month, b.dateTime.day),
          measureFn: (BloodPressure b, _) => b.diastolic,
          data: list,
        )
      ];
    else if (widget.type == 'pulse')
      return [
        charts.Series<BloodPressure, DateTime>(
          id: 'Blood Pressure Pulse Tracking',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (BloodPressure b, _) =>
              DateTime(b.dateTime.year, b.dateTime.month, b.dateTime.day),
          measureFn: (BloodPressure b, _) => b.pulse,
          data: list,
        )
      ];
    else
      return [
        charts.Series<BloodPressure, DateTime>(
          id: 'Blood Pressure Systolic  Tracking',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (BloodPressure b, _) =>
              DateTime(b.dateTime.year, b.dateTime.month, b.dateTime.day),
          measureFn: (BloodPressure b, _) => b.systolic,
          data: list,
        )
      ];
  }
}
