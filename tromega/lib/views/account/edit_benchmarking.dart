import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/classes/benchmarking.dart';
import 'package:tromega/data/http_helper.dart';
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
  late Map<String, dynamic> lastPushUps;
  late Map<String, dynamic> lastPullUps;
  late Map<String, dynamic> lastSquads;
  late Map<String, dynamic> lastCrunches;
  late HttpHelper httpHelper;
  late SharedPreferences prefs;
  bool fetching = true;

  void _changePushUps(pushUps) {
    setState(() => lastPushUps['exercise_amount'] = pushUps);
  }

  void _changePullUps(int pullUps) {
    setState(() => lastPullUps['exercise_amount'] = pullUps);
  }

  void _changeSquads(int squads) {
    setState(() => lastSquads['exercise_amount'] = squads);
  }

  void _changeCrunches(int crunches) {
    setState(() => lastCrunches['exercise_amount'] = crunches);
  }

  @override
  void initState() {
    httpHelper = HttpHelper();
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
                          pushUps: lastPushUps['exercise_amount'],
                          changePushUps: _changePushUps),
                      PullDialog(
                          pullUps: lastPullUps['exercise_amount'],
                          changePullUps: _changePullUps),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SquadsDialog(
                          squads: lastSquads['exercise_amount'],
                          changeSquads: _changeSquads),
                      CrunchesDialog(
                          crunches: lastCrunches['exercise_amount'],
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
                            //sendBenchmarking(, pullUps, squads, crunches)
                            Navigator.pushNamed(context, '/myProfile');
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
    var userId = prefs.getString("userId");
    var response = await httpHelper.postBenchmarking(pushUps);
    var response2 = await httpHelper.postBenchmarking(pullUps);
    var response3 = await httpHelper.postBenchmarking(squads);
    var response4 = await httpHelper.postBenchmarking(crunches);

    if (response && response2 && response3 && response4) {
      Navigator.pushNamed(context, '/myProfile');
    } else {
      //Visualisierung des fehlerhaften speicherns (api request failed)
      showInSnackbar(context, "Aktualisierung fehlgeschlagen");
    }
  }

  void fetchData() async {
    prefs = await SharedPreferences.getInstance();
    List<dynamic> pushUps = await httpHelper.getBenchmarking("push_ups");
    List<dynamic> pullUps = await httpHelper.getBenchmarking("pull_ups");
    List<dynamic> squads = await httpHelper.getBenchmarking("squads");
    List<dynamic> crunches = await httpHelper.getBenchmarking("crunches");

    setState(() {
      lastPushUps = pushUps.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : pushUps.last;
      lastPullUps = pullUps.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : pullUps.last;
      lastSquads = squads.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : squads.last;
      lastCrunches = crunches.isEmpty
          ? Benchmarking("", "", "", 0, 0).toJson()
          : crunches.last;
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
