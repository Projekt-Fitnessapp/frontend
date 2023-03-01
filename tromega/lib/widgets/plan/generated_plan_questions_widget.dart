import 'package:flutter/material.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/generate_plan_http_helper.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/data/generatedPlanPreferences.dart';
import 'package:tromega/widgets/account/answer_field_widget.dart';
import 'package:tromega/widgets/account/data_widget.dart';
import 'package:tromega/widgets/account/dropdown_widget.dart';
import 'package:tromega/widgets/account/routebutton_widget.dart';

class GeneratePlanQuestionWidget extends StatefulWidget {
  const GeneratePlanQuestionWidget({Key? key, required this.onFinished})
      : super(key: key);

  final Function onFinished;

  @override
  _SecondGeneratePlanQuestionWidget createState() =>
      _SecondGeneratePlanQuestionWidget();
}

class _SecondGeneratePlanQuestionWidget
    extends State<GeneratePlanQuestionWidget> {
  late GeneratePlanHttpHelper generatePlanHttpHelper;
  late GeneratedPlanPreferences preferences;

  @override
  void initState() {
    preferences = GeneratedPlanPreferences("", "", "", "");
    generatePlanHttpHelper = GeneratePlanHttpHelper();
    super.initState();
  }

  String numberOfTraininssession = "2";
  late List<String> numberOfTraininssessionOptions = ["2", "4", "6"];

  String trainingsStatus = "Untrainiert";
  late List<String> trainingStatusOptions = ["Untrainiert", "Trainiert"];

  String trainingsType = "Mit Maschinen";
  late List<String> trainingsTypeOptions = ["Mit Maschinen", "Ohne Maschinen"];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildQuestion(text: 'Wie oft willst du trainieren?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              items: numberOfTraininssessionOptions,
              currentValue: numberOfTraininssession,
              itemCallBack: (String numberOfTraininssession) {
                this.numberOfTraininssession = numberOfTraininssession;
              },
            ),
            const SizedBox(height: 16),
            buildQuestion(text: 'Wie traniert bist du?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              items: trainingStatusOptions,
              currentValue: trainingsStatus,
              itemCallBack: (String trainingsStatus) {
                this.trainingsStatus = trainingsStatus;
              },
            ),
            const SizedBox(height: 16),
            buildQuestion(text: 'Wie kannst du tranieren?'),
            const SizedBox(height: 16),
            DropDownWidget(
              color: color,
              items: trainingsTypeOptions,
              currentValue: trainingsType,
              itemCallBack: (String trainingsType) {
                this.trainingsType = trainingsType;
              },
            ),
            RouteButtonWidget(
                color: color,
                text: 'Plan generieren',
                onClick: () {
                  setState(() {
                    preferences.numberOfTraininssession =
                        numberOfTraininssession;
                    preferences.trainingsStatus = trainingsStatus;
                    preferences.trainingsType = trainingsType;
                  });
                  widget.onFinished(preferences);
                })
          ],
        ),
      ),
    );
  }
}
