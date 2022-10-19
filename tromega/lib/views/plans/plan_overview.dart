import 'dart:ui';

import '../../widgets/plan/trainingsplanBtn.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/plan_http_helper.dart';
import 'package:tromega/data/trainingPlan.dart';
import 'package:tromega/data/trainingDay.dart';
import 'package:tromega/data/exercise.dart';
import 'package:tromega/data/exerciseSetsReps.dart';
import './edit_training_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanOverview extends StatefulWidget {
  const PlanOverview({Key? key}) : super(key: key);

  @override
  State<PlanOverview> createState() => _PlanOverviewState();
}

class _PlanOverviewState extends State<PlanOverview> {
  var secondTitle = 'Meine Trainingspläne';

  var createTrainingsplan = 'Neuen Trainingsplan erstellen';

  var createTrainingsplanChoice1 = 'Manuell erstellen';

  var createTrainingsplanChoice2 = 'Automatisch erstellen';

  var trainingsplanCnt = 3;

  late List<TrainingPlan> trainingPlans = [
    // TrainingPlan("", "Push Pull Legs", 3, 1, [
    //   TrainingDay("", "Push", [
    //     ExerciseSetsReps(
    //         Exercise(
    //             "",
    //             "Bench Press",
    //             "Push the bar.",
    //             "http://d205bpvrqc9yn1.cloudfront.net/0030.gif",
    //             "breast",
    //             "barbell"),
    //         4,
    //         10)
    //   ]),
    //   TrainingDay("", "Pull", [
    //     ExerciseSetsReps(
    //         Exercise(
    //             "",
    //             "Deadlift",
    //             "Lift the bar.",
    //             "http://d205bpvrqc9yn1.cloudfront.net/0032.gif",
    //             "back",
    //             "barbell"),
    //         4,
    //         10)
    //   ]),
    //   TrainingDay("", "Legs", [
    //     ExerciseSetsReps(
    //         Exercise(
    //             "",
    //             "Deadlift",
    //             "Lift the bar.",
    //             "http://d205bpvrqc9yn1.cloudfront.net/0032.gif",
    //             "back",
    //             "barbell"),
    //         4,
    //         10)
    //   ])
    // ]),
    // TrainingPlan("", "Arnold Split", 3, 1, [
    //   TrainingDay("", "Brust Rücken", [
    //     ExerciseSetsReps(
    //         Exercise(
    //             "",
    //             "Bench Press",
    //             "Push the bar.",
    //             "http://d205bpvrqc9yn1.cloudfront.net/0030.gif",
    //             "breast",
    //             "barbell"),
    //         4,
    //         10)
    //   ]),
    //   TrainingDay("", "Beine", [
    //     ExerciseSetsReps(
    //         Exercise(
    //             "",
    //             "Deadlift",
    //             "Lift the bar.",
    //             "http://d205bpvrqc9yn1.cloudfront.net/0032.gif",
    //             "back",
    //             "barbell"),
    //         4,
    //         10)
    //   ]),
    //   TrainingDay("", "Arme", [
    //     ExerciseSetsReps(
    //         Exercise(
    //             "",
    //             "Deadlift",
    //             "Lift the bar.",
    //             "http://d205bpvrqc9yn1.cloudfront.net/0032.gif",
    //             "back",
    //             "barbell"),
    //         4,
    //         10)
    //   ])
    // ]),
    // TrainingPlan("", "GK", 1, 1, [
    //   TrainingDay("", "GK", [
    //     ExerciseSetsReps(
    //         Exercise(
    //             "",
    //             "Bench Press",
    //             "Push the bar.",
    //             "http://d205bpvrqc9yn1.cloudfront.net/0030.gif",
    //             "breast",
    //             "barbell"),
    //         4,
    //         10)
    //   ]),
    //]),
  ];

  late PlanHttpHelper planHttpHelper;
  bool fetching = true;

  @override
  initState() {
    planHttpHelper = PlanHttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: []),
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(secondTitle,
                          style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                    contentPadding: EdgeInsets.all(8.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    children: [
                                      ElevatedButton(
                                          style: Theme.of(context)
                                              .elevatedButtonTheme
                                              .style,
                                          onPressed: () async {
                                            newTrainingPlan();
                                          },
                                          child:
                                              Text(createTrainingsplanChoice1)),
                                      ElevatedButton(
                                          style: Theme.of(context)
                                              .elevatedButtonTheme
                                              .style,
                                          onPressed: () {},
                                          child:
                                              Text(createTrainingsplanChoice2))
                                    ]);
                              },
                            );
                          },
                          child: Text(createTrainingsplan)),
                    ),
                  ],
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: trainingPlans.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TrainingsplanBtn(
                          trainingPlan: trainingPlans[index]);
                    }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomMenu(index: 1),
    );
  }

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    //var userId = await prefs.getString("userId");
    var userId = "634dad62663403c8063adc41";
    List<TrainingPlan> initTrainingPlans =
        await planHttpHelper.getTrainingPlans(userId);
    setState(() {
      trainingPlans = initTrainingPlans;
      fetching = false;
    });
  }

  void newTrainingPlan() async {
    final prefs = await SharedPreferences.getInstance();
    //var userId = await prefs.getString("userId");
    var userId = "634dad62663403c8063adc41";
    TrainingPlan trainingPlan =
        TrainingPlan("", "Neuer Trainingsplan", 1, 0, []);
    var response = await planHttpHelper.postTrainingPlan(userId, trainingPlan);
    if (response != "") {
      trainingPlan.setId = response;
    }
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPlanView(trainingPlan: trainingPlan),
        ));
  }
}
