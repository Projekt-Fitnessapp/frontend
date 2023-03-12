import 'package:shared_preferences/shared_preferences.dart';

import '../../data/plan_http_helper.dart';
import '../../widgets/plan/edit_plan_view_column.dart';
import '../../widgets/plan/plan_view_column.dart';
import './edit_training_view.dart';
import '../../widgets/plan/trainingstagBtn.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/trainingPlan.dart';

class PlanDetailsView extends StatefulWidget {
  //View für die Visualisierung eines Trainingsplans mit seinen Trainingstagen
  const PlanDetailsView({Key? key, required this.trainingPlan})
      : super(key: key);
  final TrainingPlan trainingPlan;

  @override
  State<PlanDetailsView> createState() => _PlanDetailsViewState();
}

class _PlanDetailsViewState extends State<PlanDetailsView> {
  late PageController _pageViewController;
  int pageIndex = 0;

  late PlanHttpHelper planHttpHelper;

  @override
  initState() {
    planHttpHelper = PlanHttpHelper();
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
      appBar: AppBar_Icon(actions: const []),
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
        widget.trainingPlan.trainingDays.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                      onPressed: (() {
                        activatePlan(widget.trainingPlan.getId);
                      }),
                      child: const Text("Plan aktivieren")),
                ),
              )
            : const Text(""),
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
    TrainingPlan trainingPlan =
        TrainingPlan("", "Neuer Trainingsplan", 1, 0, []);
    var response = await planHttpHelper.putActivePlan(userId, id);
    if (response) {
      showInSnackbar(context, "Trainingsplan erfolgreich aktiviert");
    } else {
      showInSnackbarError(context, "Fehler bei der Aktivierung");
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
