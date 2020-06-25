import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderly_app/models/tracker.dart';
import 'package:flutter/material.dart';

class WeightChart extends StatefulWidget {
  final bool animate;
  final String userID;
  WeightChart({
    this.animate,
    this.userID,
  });

  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  WeightTracker weightTracker;
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

  Future<List<charts.Series<Weight, DateTime>>> _createSampleData() async {
    weightTracker = WeightTracker();
    QuerySnapshot snapshot = await Firestore.instance
        .collection('tracker')
        .document(widget.userID)
        .collection('weight')
        .getDocuments();

    List list = weightTracker.loadData(snapshot);

    return [
      charts.Series<Weight, DateTime>(
        id: 'Weight Tracking',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Weight weight, _) => DateTime(
            weight.dateTime.year, weight.dateTime.month, weight.dateTime.day),
        measureFn: (Weight weight, _) => weight.weight,
        data: list,
      )
    ];
  }
}
