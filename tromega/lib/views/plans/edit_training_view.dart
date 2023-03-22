// Author: Steffen

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/plan/edit_plan_view_column.dart';
import '../../data/classes/training_day.dart';
import '../../data/http_helper.dart';
import '../../data/classes/training_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPlanView extends StatefulWidget {
  //View zum editieren von Trainingsplänen

  EditPlanView(
      {Key? key, required this.trainingPlan, this.withBackButton = true})
      : super(key: key);
  final TrainingPlan trainingPlan;
  final bool withBackButton;
  late TrainingPlan trainingPlanCopy = TrainingPlan(
      trainingPlan.getId,
      trainingPlan.name,
      trainingPlan.split,
      trainingPlan.nextDay,
      trainingPlan.trainingDays);

  @override
  State<EditPlanView> createState() => _EditPlanViewState();
}

class _EditPlanViewState extends State<EditPlanView> {
  late HttpHelper httpHelper;

  // ignore: unused_field
  int _count = 0;

  //Methode zum aktualisieren von Daten, wird an Child View weitergegeben
  void _update(int count) {
    setState(() => _count = count);
  }

  late PageController _pageViewController;
  int pageIndex = 0;

  @override
  initState() {
    super.initState();
    httpHelper = const HttpHelper();
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBarIcon(
        actions: const [],
        withBackButton: widget.withBackButton,
      ),
      body: Column(children: [
        Row(children: <Widget>[
          Flexible(
              flex: 5,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                          onChanged: (value) {
                            widget.trainingPlanCopy.name = value;
                          },
                          onSubmitted: (value) {
                            widget.trainingPlanCopy.name = value;
                          },
                          textAlign: TextAlign.left,
                          controller: TextEditingController(
                            text: widget.trainingPlanCopy.name,
                          ),
                          style: Theme.of(context).textTheme.headlineLarge!,
                          cursorColor: Theme.of(context).primaryColor,
                          focusNode: FocusNode(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ] //Länge des Eingabefeldes begrenzen,
                          )))),
          Flexible(
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: const Icon(Icons.save_outlined),
                    iconSize: 32,
                    onPressed: () {
                      onSave(widget.trainingPlanCopy);
                    }),
              )),
        ]),
        SizedBox(
            height: 50,
            child: SizedBox(
                child: ListView(scrollDirection: Axis.horizontal, children: [
              if (widget.trainingPlanCopy.trainingDays.isNotEmpty)
                for (var day in widget.trainingPlanCopy.trainingDays)
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style!,
                          onPressed: () {
                            _pageViewController.animateToPage(
                                widget.trainingPlanCopy.trainingDays
                                    .indexOf(day),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(day.name))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style!,
                      onPressed: () {
                        newTrainingDay();
                      },
                      child: const Icon(Icons.add)))
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
            for (var day in widget.trainingPlanCopy.trainingDays)
              EditPlanViewColumn(
                  day: day,
                  update: _update,
                  trainingPlan: widget.trainingPlanCopy),
          ],
        ))
      ]),
    );
  }

  void onSave(TrainingPlan trainingPlan) async {
    //speichern des Trainingsplans mithilfe einer API Request
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    var response =
        await httpHelper.putTrainingPlan(trainingPlan.getId, trainingPlan);
    if (response) {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => App(currentIndex: 1),
          ));
    } else {
      //Visualisierung des fehlerhaften speicherns (api request failed)
      showInSnackbar(context, "Speichern fehlgeschlagen");
    }
  }

  void newTrainingDay() async {
    //Posten eines neuen Trainingstages wenn ein neuer Tag erstellt wird
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    TrainingDay trainingDay = TrainingDay(
        "",
        "Tag ${widget.trainingPlanCopy.trainingDays.isNotEmpty ? widget.trainingPlanCopy.trainingDays.length + 1 : "1"}",
        []);
    var response = await httpHelper.postTrainingDay(trainingDay, userId);
    widget.trainingPlanCopy.trainingDays.add(TrainingDay(
        response,
        "Tag ${widget.trainingPlanCopy.trainingDays.isNotEmpty ? widget.trainingPlanCopy.trainingDays.length + 1 : "1"}",
        []));
    setState(() {});
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
}
