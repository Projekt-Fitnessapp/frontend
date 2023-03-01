import 'package:flutter/material.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/plan/generated_plan_questions_widget.dart';
import '../../data/generate_plan_http_helper.dart';
import '../../data/generatedPlanPreferences.dart';

class GeneratePlanView extends StatefulWidget {
  //View zum generieren von Trainingsplänen
  GeneratePlanView({Key? key, required this.generatedPlanPreferences})
      : super(key: key);
  final GeneratedPlanPreferences generatedPlanPreferences;
  late GeneratedPlanPreferences generatedPlanPreferencesCopy =
      GeneratedPlanPreferences(
          generatedPlanPreferences.getId,
          generatedPlanPreferences.numberOfTraininssession,
          generatedPlanPreferences.trainingsStatus,
          generatedPlanPreferences.trainingsType);

  @override
  State<GeneratePlanView> createState() => _GeneratePlanViewState();
}

class _GeneratePlanViewState extends State<GeneratePlanView> {
  late GeneratePlanHttpHelper generatePlanHttpHelper;

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
              onFinished: (GeneratedPlanPreferences generatedPlanPreferences) {
            generatePlanHttpHelper
                .postGeneratedPlanPreferences(
                    generatedPlanPreferences.getId, generatedPlanPreferences)
                .then(
                    (value) => Navigator.pushNamed(context, '/myWorkoutPlans'));
          })
        ],
      ),
    );
  }
}
