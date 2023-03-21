import 'package:flutter/material.dart';
import 'package:tromega/data/http_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tromega/data/classes/stats_pair.dart';

class Graph extends StatefulWidget {
  final String exercise;

  const Graph({Key? key, required this.exercise});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  bool fetching = true;

  late List<StatsPair> statsPairs = [];

  late HttpHelper httpHelper;

  @override
  void initState() {
    httpHelper = const HttpHelper();
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
                SizedBox(
                  height: 300,
                  child: SfCartesianChart(
                      margin: const EdgeInsets.all(30.0),
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries<StatsPair, String>>[
                        // Renders column chart
                        LineSeries<StatsPair, String>(
                          dataSource: statsPairs,
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
        await httpHelper.getBenchmarking(exercise.toLowerCase());
    print(stats.last.getExerciseAmount);

    setState(() {
      statsPairs = stats;
      fetching = false;
    });
  }
}
