import '../../widgets/plan/trainingsplan_btn.dart';
import 'package:flutter/material.dart';
import '../../widgets/shared/app_bar.dart';
import 'package:tromega/data/http_helper.dart';
import 'package:tromega/data/classes/training_plan.dart';
import './edit_training_view.dart';
import './generate_training_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanOverview extends StatefulWidget {
  //View für die Übersicht aller Trainingspläne
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
  var generatedTrainingsplan = TrainingPlan("", "", 0, 0, []);

  late List<TrainingPlan> trainingPlans = [];

  late HttpHelper planHttpHelper;
  bool fetching = true;

  @override
  initState() {
    planHttpHelper = const HttpHelper();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarIcon(actions: const []),
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : Row(
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
                                style:
                                    Theme.of(context).textTheme.headlineLarge),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ElevatedButton(
                                style:
                                    Theme.of(context).elevatedButtonTheme.style,
                                onPressed: () {
                                  //Dialog zur Abfrage welcher Trainingsplan erstellt werden soll
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                          contentPadding:
                                              const EdgeInsets.all(8.0),
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
                                                child: Text(
                                                    createTrainingsplanChoice1)),
                                            ElevatedButton(
                                                style: Theme.of(context)
                                                    .elevatedButtonTheme
                                                    .style,
                                                onPressed: () async {
                                                  setState(() {
                                                    generatedTrainingsplan =
                                                        newGeneratedTrainingPlan();
                                                  });
                                                },
                                                child: Text(
                                                    createTrainingsplanChoice2))
                                          ]);
                                    },
                                  );
                                },
                                child: Text(createTrainingsplan)),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ShaderMask(
                          shaderCallback: (Rect rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.purple,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.purple
                              ],
                              stops: [
                                0.0,
                                0.05,
                                0.95,
                                1.0
                              ], // 10% purple, 80% transparent, 10% purple
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.dstOut,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: trainingPlans.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TrainingsplanBtn(
                                    trainingPlan: trainingPlans[index]);
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void fetchData() async {
    //Laden der Trainingspläne eines Nutzers
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    List<TrainingPlan> initTrainingPlans =
        await planHttpHelper.getTrainingPlans(userId);
    setState(() {
      trainingPlans = initTrainingPlans;
      fetching = false;
    });
  }

  void newTrainingPlan() async {
    //Erstellung eines neuen leeren Trainingsplans
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    userId ??= "634dad62663403c8063adc41";
    TrainingPlan trainingPlan =
        TrainingPlan("", "Neuer Trainingsplan", 1, 0, []);
    var response = await planHttpHelper.postTrainingPlan(userId, trainingPlan);
    if (response != "") {
      trainingPlan.setId = response; //setzen der id für spätere updates
      //navigation zur editierung des neuen Plans
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPlanView(trainingPlan: trainingPlan),
          ));
    } else {
      showInSnackbar(context, "Fehler bei Erstellung");
    }
  }

  newGeneratedTrainingPlan() async {
    //navigation zur generierung eines neuen Plans
    return await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GeneratePlanView(),
        ));
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
