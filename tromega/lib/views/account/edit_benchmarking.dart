import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/classes/benchmarking.dart';
import 'package:tromega/data/classes/stats_pair.dart';
import 'package:tromega/data/http_helper.dart';
import '../../app.dart';
import '../../widgets/account/crunches_dialog.dart';
import '../../widgets/account/pull_dialog.dart';
import '../../widgets/account/push_dialog.dart';
import '../../widgets/account/squads_dialog.dart';
import '../../widgets/shared/app_bar.dart';

class EditBenchmarking extends StatefulWidget {
  const EditBenchmarking({Key? key}) : super(key: key);

  @override
  State<EditBenchmarking> createState() => _EditBenchmarkingState();
}

class _EditBenchmarkingState extends State<EditBenchmarking> {
  late StatsPair lastPushUps;
  late StatsPair lastPullUps;
  late StatsPair lastSquads;
  late StatsPair lastCrunches;
  late Benchmarking thisPushUps;
  late Benchmarking thisPullUps;
  late Benchmarking thisSquads;
  late Benchmarking thisCrunches;
  late HttpHelper httpHelper;
  late SharedPreferences prefs;
  bool fetching = true;

  void _changePushUps(pushUps) {
    setState(() => lastPushUps.exerciseAmount = pushUps);
  }

  void _changePullUps(int pullUps) {
    setState(() => lastPullUps.exerciseAmount = pullUps);
  }

  void _changeSquads(int squads) {
    setState(() => lastSquads.exerciseAmount = squads);
  }

  void _changeCrunches(int crunches) {
    setState(() => lastCrunches.exerciseAmount = crunches);
  }

  @override
  void initState() {
    httpHelper = HttpHelper();
    thisPushUps = Benchmarking("", "", "", 0, 0);
    thisPullUps = Benchmarking("", "", "", 0, 0);
    thisSquads = Benchmarking("", "", "", 0, 0);
    thisCrunches = Benchmarking("", "", "", 0, 0);
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBarIcon(
        actions: const [],
      ),
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Center(
                      child: Text(
                        "Benchmarkings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: color,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Aktualisiere die Anzahl der Übungen",
                        style: TextStyle(
                          fontSize: 18,
                          color: color,
                        ),
                      ),
                    ),
                  ]),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      PushDialog(
                          pushUps: lastPushUps.exerciseAmount,
                          changePushUps: _changePushUps),
                      PullDialog(
                          pullUps: lastPullUps.exerciseAmount,
                          changePullUps: _changePullUps),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SquadsDialog(
                          squads: lastSquads.exerciseAmount,
                          changeSquads: _changeSquads),
                      CrunchesDialog(
                          crunches: lastCrunches.exerciseAmount,
                          changeCrunches: _changeCrunches),
                    ]),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            maximumSize: const Size(200, 50),
                            primary: const Color.fromARGB(1000, 0, 48, 80),
                          ),
                          onPressed: () {
                            setState(() {
                              thisPushUps.exercise_amount =
                                  lastPushUps.exerciseAmount;
                              thisPushUps.exercise_name = "push_ups";
                              thisPullUps.exercise_amount =
                                  lastPullUps.exerciseAmount;
                              thisPullUps.exercise_name = "pull_ups";
                              thisSquads.exercise_amount =
                                  lastSquads.exerciseAmount;
                              thisSquads.exercise_name = "squads";
                              thisCrunches.exercise_amount =
                                  lastCrunches.exerciseAmount;
                              thisCrunches.exercise_name = "crunches";
                            });
                            sendBenchmarking(thisPushUps, thisPullUps,
                                thisSquads, thisCrunches);
                            //Navigator.pushNamed(context, '/myProfile');
                          },
                          child: const Text(
                            'Benchmarking aktualisieren',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
    );
  }

  void sendBenchmarking(Benchmarking pushUps, Benchmarking pullUps,
      Benchmarking squads, Benchmarking crunches) async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId") ?? '';
    pullUps.userId = userId;
    pushUps.userId = userId;
    squads.userId = userId;
    crunches.userId = userId;
    await Future.wait([
      httpHelper.postBenchmarking(pushUps),
      httpHelper.postBenchmarking(pullUps),
      httpHelper.postBenchmarking(squads),
      httpHelper.postBenchmarking(crunches),
    ]);
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => App(currentIndex: 4),
        ));
  }

  void fetchData() async {
    prefs = await SharedPreferences.getInstance();
    List<dynamic> pushUps = await httpHelper.getBenchmarking("push_ups");
    List<dynamic> pullUps = await httpHelper.getBenchmarking("pull_ups");
    List<dynamic> squads = await httpHelper.getBenchmarking("squads");
    List<dynamic> crunches = await httpHelper.getBenchmarking("crunches");

    setState(() {
      lastPushUps =
          pushUps.isEmpty ? StatsPair(0, DateTime(2023)) : pushUps.last;
      lastPullUps =
          pullUps.isEmpty ? StatsPair(0, DateTime(2023)) : pullUps.last;
      lastSquads = squads.isEmpty ? StatsPair(0, DateTime(2023)) : squads.last;
      lastCrunches =
          crunches.isEmpty ? StatsPair(0, DateTime(2023)) : crunches.last;
      fetching = false;
    });
  }

  void showInSnackbar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }
}
