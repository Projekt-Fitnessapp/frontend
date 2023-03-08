import 'package:flutter/material.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/plan/generated_plan_questions_widget.dart';
import '../../data/generate_plan_http_helper.dart';
import '../../data/generatedPlanPreferences.dart';
import 'package:tromega/data/trainingPlan.dart';
import './plan_details.dart';

class GeneratePlanView extends StatefulWidget {
  const GeneratePlanView({super.key});

  //View zum generieren von Trainingsplänen
  @override
  State<GeneratePlanView> createState() => _GeneratePlanViewState();
}

class _GeneratePlanViewState extends State<GeneratePlanView> {
  late GeneratePlanHttpHelper generatePlanHttpHelper;

  late TrainingPlan generatedTrainingsplan;

  @override
  void initState() {
    generatePlanHttpHelper = GeneratePlanHttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          GeneratePlanQuestionWidget(
            onFinished:
                (GeneratedPlanPreferences generatedPlanPreferences) async {
              generatedTrainingsplan = await generatePlanHttpHelper
                  .postGeneratedPlanPreferences(generatedPlanPreferences);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlanDetailsView(trainingPlan: generatedTrainingsplan),
                  ));
              /*
                  .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => App(currentIndex: 1),
                      )));
                      */
            },
          )
        ],
      ),
    );
  }
}
