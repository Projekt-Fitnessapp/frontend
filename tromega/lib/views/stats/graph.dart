import 'package:flutter/material.dart';
import 'package:tromega/data/stats_http_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tromega/data/stats_pair.dart';
import 'package:tromega/views/stats/graph.dart';
import '../../widgets/bottom_menu.dart';
import 'package:intl/intl.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/shared/theme.dart';

class Graph extends StatefulWidget {
  final String exercise;

  const Graph({Key? key, required this.exercise});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  bool fetching = false;

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

  late StatsHttpHelper statsHttpHelper;

  @override
  void initState() {
    statsHttpHelper = StatsHttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetching
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
            child: Column(
              children: [
                Text(
                  widget.exercise,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 300,
                  child: SfCartesianChart(
                      margin: const EdgeInsets.all(30.0),
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries<StatsPair, String>>[
                        // Renders column chart
                        LineSeries<StatsPair, String>(
                            dataSource: stats_pairs,
                            xValueMapper: (StatsPair data, _) => data.date,
                            yValueMapper: (StatsPair data, _) =>
                                data.exerciseAmount)
                      ]),
                ),
              ],
            ),
          );
  }

  void fetchData() async {
    //gets the trainingsdata of last week (when has the user trained)
    dynamic test = await StatsHttpHelper().getBenchmarking();

    setState(() {
      print(test[0]['date']);
      fetching = false;
    });
  }
}
