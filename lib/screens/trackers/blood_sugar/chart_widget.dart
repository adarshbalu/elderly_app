import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/tracker.dart';
import 'package:flutter/material.dart';

class BloodSugarChart extends StatefulWidget {
  final bool animate;
  final String userID;
  BloodSugarChart({
    this.animate,
    this.userID,
  });

  @override
  _BloodSugarChartState createState() => _BloodSugarChartState();
}

class _BloodSugarChartState extends State<BloodSugarChart> {
  BloodSugarTracker bloodSugar;
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

  Future<List<charts.Series<BloodSugar, DateTime>>> _createSampleData() async {
    bloodSugar = BloodSugarTracker();
    QuerySnapshot snapshot = await Firestore.instance
        .collection('tracker')
        .document(widget.userID)
        .collection('blood_sugar')
        .getDocuments();

    List list = bloodSugar.loadData(snapshot);

    return [
      charts.Series<BloodSugar, DateTime>(
        id: 'Blood Sugar Tracking',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (BloodSugar b, _) =>
            DateTime(b.dateTime.year, b.dateTime.month, b.dateTime.day),
        measureFn: (BloodSugar b, _) => b.bloodSugar,
        data: list,
      )
    ];
  }
}
