import 'package:flutter/material.dart';
import '../../widgets/shared/app_bar.dart';
import '../../widgets/plan/generated_plan_questions_widget.dart';
import '../../data/generate_plan_http_helper.dart';
import '../../data/generatedPlanPreferences.dart';

class GeneratePlanView extends StatefulWidget {
  const GeneratePlanView({super.key});

  //View zum generieren von Trainingsplänen

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
            print("finished");
            generatePlanHttpHelper
                .postGeneratedPlanPreferences(generatedPlanPreferences)
                .then((value) => Navigator.pushNamed(context, '/myProfile'));
          })
        ],
      ),
    );
  }
}
