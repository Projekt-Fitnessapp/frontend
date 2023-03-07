import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tromega/data/stats_pair.dart';
import 'package:tromega/data/stats_http_helper.dart';
import 'package:tromega/views/stats/graph.dart';
import '../widgets/bottom_menu.dart';
import 'package:intl/intl.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/shared/theme.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class StatisticsView extends StatefulWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  Widget build(BuildContext context) {
    final List<StatsPair> stats_pairs = [
      StatsPair(10, DateFormat('yyyy-MM-dd').format(DateTime.utc(2011, 11, 9))),
      StatsPair(25, DateFormat('yyyy-MM-dd').format(DateTime.utc(2012, 11, 9))),
      StatsPair(50, DateFormat('yyyy-MM-dd').format(DateTime.utc(2013, 11, 9))),
      StatsPair(56, DateFormat('yyyy-MM-dd').format(DateTime.utc(2014, 11, 9))),
      StatsPair(44, DateFormat('yyyy-MM-dd').format(DateTime.utc(2015, 11, 9))),
      StatsPair(54, DateFormat('yyyy-MM-dd').format(DateTime.utc(2016, 11, 9))),
      StatsPair(34, DateFormat('yyyy-MM-dd').format(DateTime.utc(2017, 11, 9))),
      StatsPair(26, DateFormat('yyyy-MM-dd').format(DateTime.utc(2018, 11, 9))),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar_Icon(
          actions: [],
        ),
        body: ListView(
          shrinkWrap: true,
          children: const [
            Graph(exercise: "Pullup"),
            Graph(exercise: "Pushup"),
            Graph(exercise: "Weightlifting"),
            Graph(exercise: "Test"),
          ],
        ),
      ),
    );
  }
}
