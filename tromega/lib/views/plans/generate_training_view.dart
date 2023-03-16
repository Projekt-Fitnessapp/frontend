import 'package:flutter/material.dart';
import 'package:tromega/views/plans/edit_training_view.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/plan/generated_plan_questions_widget.dart';
import '../../data/http_helper.dart';
import '../../data/classes/generated_plan_preferences.dart';
import 'package:tromega/data/classes/training_plan.dart';
import './plan_details.dart';

class GeneratePlanView extends StatefulWidget {
  const GeneratePlanView({super.key});

  //View zum generieren von Trainingsplänen
  @override
  State<GeneratePlanView> createState() => _GeneratePlanViewState();
}

class _GeneratePlanViewState extends State<GeneratePlanView> {
  late HttpHelper httpHelper;

  late TrainingPlan generatedTrainingsplan;

  @override
  void initState() {
    httpHelper = const HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarIcon(actions: const []),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          GeneratePlanQuestionWidget(
            // Wenn Planpräferenzen abgeschickt werden diese ans Backend senden
            // und warten bis generierter Plan zurückgegeben wird
            onFinished:
                (GeneratedPlanPreferences generatedPlanPreferences) async {
              generatedTrainingsplan = await httpHelper
                  .postGeneratedPlanPreferences(generatedPlanPreferences);
              // Generierten Plan an die Plan Detailansicht View übergeben
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPlanView(
                      trainingPlan: generatedTrainingsplan,
                      withBackButton: false,
                    ),
                  ));
            },
          )
        ],
      ),
    );
  }
}
