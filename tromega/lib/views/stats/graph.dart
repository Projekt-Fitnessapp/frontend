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
  bool fetching = true;

  late List<StatsPair> stats_pairs = [];

  late StatsHttpHelper statsHttpHelper;

  @override
  void initState() {
    statsHttpHelper = StatsHttpHelper();
    fetchData(widget.exercise);
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
                          xValueMapper: (StatsPair data, _) =>
                              "${data.date.day}-${data.date.month}-${data.date.year}",
                          //data.date.toString(),
                          yValueMapper: (StatsPair data, _) =>
                              data.exerciseAmount,
                        )
                      ]),
                ),
              ],
            ),
          );
  }

  void fetchData(String exercise) async {
    //gets the trainingsdata of last week (when has the user trained)
    List<StatsPair> stats =
        await StatsHttpHelper().getBenchmarking(exercise.toLowerCase());

    setState(() {
      stats_pairs = stats;
      fetching = false;
    });
  }
}
