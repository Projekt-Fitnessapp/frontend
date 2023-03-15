import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';
import '../../data/http_helper.dart';
import '../../widgets/plan/plan_view_column.dart';
import './edit_training_view.dart';
import 'package:flutter/material.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/classes/training_plan.dart';

class PlanDetailsView extends StatefulWidget {
  //View für die Visualisierung eines Trainingsplans mit seinen Trainingstagen
  PlanDetailsView(
      {Key? key, required this.trainingPlan, required this.activePlanId})
      : super(key: key);
  final TrainingPlan trainingPlan;
  String activePlanId;

  @override
  State<PlanDetailsView> createState() => _PlanDetailsViewState();
}

class _PlanDetailsViewState extends State<PlanDetailsView> {
  late PageController _pageViewController;
  int pageIndex = 0;

  late HttpHelper httpHelper;

  @override
  initState() {
    httpHelper = const HttpHelper();
    super.initState();
    _pageViewController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarIcon(actions: const []),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
          child: Row(
            children: [
              Flexible(
                flex: 9,
                fit: FlexFit.tight,
                child: Text(widget.trainingPlan.name,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 32,
                        onPressed: () async {
                          //Navigation in die View zum editieren des Plans
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPlanView(
                                  trainingPlan: widget.trainingPlan,
                                ),
                              ));
                        }),
                  ))
            ],
          ),
        ),
        Row(
          children: [
            widget.trainingPlan.trainingDays.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: widget.activePlanId != widget.trainingPlan.getId
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: (() {
                                activatePlan(widget.trainingPlan.getId);
                              }),
                              child: const Text("Plan aktivieren"))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(1000, 200, 200, 200),
                              ),
                              child: const Text("Plan aktiv"),
                              onPressed: (() {}),
                            ),
                    ),
                  )
                : const Text(""),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: (() {
                      deletePlan(widget.trainingPlan.getId);
                    }),
                    child: const Text("Plan löschen")),
              ),
            ),
          ],
        ),
        SizedBox(
            height: 50,
            child: SizedBox(
                child: ListView(scrollDirection: Axis.horizontal, children: [
              if (widget.trainingPlan.trainingDays.isNotEmpty)
                for (var day in widget.trainingPlan.trainingDays)
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style!,
                          onPressed: () {
                            _pageViewController.animateToPage(
                                widget.trainingPlan.trainingDays.indexOf(day),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(day.name))),
            ]))),
        Expanded(
            child: PageView(
          controller: _pageViewController,
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: [
            for (var day in widget.trainingPlan.trainingDays)
              PlanViewColumn(day: day, trainingPlan: widget.trainingPlan),
          ],
        ))
      ]),
    );
  }

  void activatePlan(String id) async {
    //Erstellung eines neuen leeren Trainingsplans
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    var response = await httpHelper.putActivePlan(userId, id);
    if (response) {
      showInSnackbar(context, "Trainingsplan erfolgreich aktiviert");
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => App(currentIndex: 0),
          ));
    } else {
      showInSnackbarError(context, "Fehler bei der Aktivierung");
    }
  }

  void deletePlan(String id) async {
    //Erstellung eines neuen leeren Trainingsplans
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    var response = await httpHelper.deleteTrainingsplan(userId, id);
    if (response) {
      showInSnackbar(context, "Trainingsplan erfolgreich gelöscht");
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => App(currentIndex: 1),
          ));
    } else {
      showInSnackbarError(context, "Fehler bei der Löschung");
    }
  }

  //Snackbar für Alerts
  void showInSnackbar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }

  //Snackbar für Errors
  void showInSnackbarError(BuildContext context, String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(value),
      ),
    );
  }
}
