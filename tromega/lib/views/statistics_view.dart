import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tromega/data/stats_pair.dart';
import '../widgets/bottom_menu.dart';
import 'package:intl/intl.dart';

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
        appBar: AppBar(
          title: Text("DrawGraph Package"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
                child: Column(
                  children: [
                    Text(
                      "Pullups",
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
                                    data.number)
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
                child: Column(
                  children: [
                    Text(
                      "PushUps",
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
                                    data.number)
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
                child: Column(
                  children: [
                    Text(
                      "Weightlifting",
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
                                    data.number)
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
                child: Column(
                  children: [
                    Text(
                      "Test",
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
                                    data.number)
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomMenu(index: 2),
      ),
    );
  }
}
