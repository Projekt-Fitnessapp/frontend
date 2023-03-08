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
    return Scaffold(
      appBar: AppBar_Icon(
        actions: const [],
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [
          Graph(exercise: "Pullups"),
          Graph(exercise: "Pushups"),
          Graph(exercise: "Weightlifting"),
          Graph(exercise: "Week_counter"),
        ],
      ),
    );
  }
}
